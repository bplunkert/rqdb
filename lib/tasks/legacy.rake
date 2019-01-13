namespace :legacy do
  desc 'Migrate data from RQMS legacy (Beta 2.0) database and copy to current environment'
  task migrate_database: :environment do
    require 'mysql2'
    require 'open3'
    require 'optparse'

    @options = {}
    o = OptionParser.new do |opts|
      opts.banner = 'Usage: rake legacy:migrate_database [options]'
      opts.on('-c CONFIGFILE', '--configfile CONFIGFILE') { |configfile| @options[:configfile] = configfile }
      opts.on('-w', '--write', 'Write the migrated objects to the Rash on Rails database') { @options[:write] = true }
      opts.on_tail('--help', 'Show this message') do
        puts opts
        exit
      end
    end

    args = o.order!(ARGV) {}
    o.parse!(args)

    unless @options[:configfile]
      STDERR.puts 'Error: required argument --configfile is missing'
      exit 1
    end

    config = {}

    f = File.read(@options[:configfile])   

    detected_versions = []
    detected_versions << '1.2.2'    if parse_php_config('dbname')
    detected_versions << '2.0_BETA' if parse_php_config('database')
    detected_versions << 'fork'     if parse_php_config("CONFIG['dbname']")

    if detected_versions.length == 0
      STDERR.puts 'Error: Unknown config syntax version found; version detection failed.'
      exit 1
    elsif detected_versions.length == 1
      config_version = detected_versions.first
    elsif detected_versions.length > 1
      STDERR.puts 'Error: Multiple config syntaxes found; version detection failed.'
      STDERR.puts detected_versions
      exit 1
    end

    puts "Detected version #{config_version}"

    case config_version
    when '1.2.2'
      legacy_news_table                      = parse_php_config('newstable')
      legacy_queue_table                     = parse_php_config('subtable')
      legacy_quotes_table                    = parse_php_config('quotetable')
      legacy_quotes_flag_field               = 'check'
      legacy_quotes_flag_field_flagged_value = '0'
      legacy_users_table                     = parse_php_config('rashusers')
      legacy_votes_table                     = nil

      dbhost                                 = parse_php_config('hostname')
      dbsocket                               = parse_php_config('socket')
      dbname                                 = parse_php_config('dbname')
      dbusername                             = parse_php_config('username')
      dbpassword                             = parse_php_config('dbpassword')
    when '2.0_BETA'
      legacy_news_table                      = 'rash_news'
      legacy_queue_table                     = 'rash_queue'
      legacy_quotes_table                    = 'rash_quotes'
      legacy_quotes_flag_fi eld              = 'flag'
      legacy_quotes_flag_field_flagged_value = '1'
      legacy_users_table                     = 'rash_users'
      legacy_votes_table                     = 'rash_tracking'

      dbhost                                 = parse_php_config('hostspec')
      dbsocket                               = parse_php_config('socket')
      dbname                                 = parse_php_config('database')
      dbusername                             = parse_php_config('username')
      dbpassword                             = parse_php_config('password')
    when 'fork'
      db_table_prefix                        = parse_php_config("CONFIG['db_table_prefix']")
      legacy_news_table                      = "#{db_table_prefix}_news"
      legacy_queue_table                     = "#{db_table_prefix}_queue"
      legacy_quotes_table                    = "#{db_table_prefix}_quotes"
      legacy_quotes_flag_field               = 'flag'
      legacy_quotes_flag_field_flagged_value = '1'
      legacy_users_table                     = parse_php_config('rashusers')
      legacy_votes_table                     = nil

      dbhost                                 = parse_php_config("CONFIG['hostspec']")
      dbsocket                               = parse_php_config("CONFIG['socket']")
      dbname                                 = parse_php_config("CONFIG['database']")
      dbusername                             = parse_php_config("CONFIG['username']")
      dbpassword                             = parse_php_config("CONFIG['password']")
    else
      STDERR.puts "Error: unsupported version #{config_version}"
      exit 1
    end

    if dbhost and dbsocket
      STDERR.puts 'Error: both DB host and DB socket cannot be specified in parsed config file.'
      exit 1
    elsif dbhost
      host_or_socket = 'host'
    elsif dbsocket
      host_or_socket = 'socket'
    else
      STDERR.puts 'Error: neither DB host nor DB socket name specified in parsed config file.'
      exit 1
    end

    puts "Connecting to MySQL #{host_or_socket} #{dbhost}"
    legacy_mysql = case host_or_socket
    when 'host'
      Mysql2::Client.new(host: dbhost, database: dbname, username: dbusername, password: dbpassword)
    when 'socket'
      Mysql2::Client.new(socket: dbsocket, database: dbname, username: dbusername, password: dbpassword)
    end

    legacy_news   = legacy_mysql.query("SELECT * FROM #{legacy_news_table}")
    legacy_news.each do |legacy_announcement|
      puts "Migrating legacy announcement #{legacy_announcement['id']}"
      announcement = Announcement.new(text: legacy_announcement['news'], created_at: Time.at(legacy_announcement['date']))
      if @options[:write]
        unless announcement.save
          STDERR.puts "Error: failed to save #{announcement.text}"
        end
      end
    end

    legacy_queue  = legacy_mysql.query("SELECT * FROM #{legacy_queue_table}")
    legacy_queue.each do |legacy_quote|
      puts "Migrating legacy queued quote #{legacy_quote['id']}"      
      quote = Quote.new(text: legacy_quote['quote'], created_at: Time.at(legacy_quote['date'], submitterip: legacy_quote['submitip']))
      quote.save if @options[:write]

      if @options[:write]
        unless quote.save
          STDERR.puts "Error: failed to save #{quote.text}"
        end
      end
    end

    legacy_quotes = legacy_mysql.query("SELECT * FROM #{legacy_quotes_table}")
    legacy_quotes.each do |legacy_quote|
      puts "Migrating legacy quote #{legacy_quote['id']}"
      if legacy_quotes_flag_field == legacy_quotes_flag_field_flagged_value
        is_flagged = true
      else
        is_flagged = false
      end
      quote = Quote.new(text: legacy_quote['quote'], score: legacy_quote['rating'], flagged: legacy_quote['flag'], approved: true, created_at: Time.at(legacy_quote['date']))
      if @options[:write]
        unless quote.save
          STDERR.puts "Error: failed to save #{quote.text}"
        end
      end
    end

    legacy_users  = legacy_mysql.query("SELECT * FROM #{legacy_users_table}")
    legacy_users.each do |legacy_user|
      random_password = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).shuffle[0,10].join        
      puts "Migrating legacy user #{legacy_user['user']}, assigning username #{legacy_user['user']}@admin.admin and random password #{random_password}"
      user = User.new(email: "#{legacy_user['user']}@admin.admin", password: random_password)
      if @options[:write]
        unless user.save
          STDERR.puts "Error: failed to save #{user.email}"
        end
      end
    end

    if legacy_votes_table
      legacy_votes  = legacy_mysql.query("SELECT * FROM #{legacy_votes_table}")
      legacy_votes.each do |legacy_vote|
        puts "Migrating legacy vote #{legacy_vote['id']}"
        unless legacy_vote['vote'].nil? or legacy_vote['vote'].length == 0
          vote = Vote.new(quote_id: legacy_vote['quote_id'], ipaddress: legacy_vote['ip'], value: legacy_vote['vote'])
          if @options[:write]
            begin
              vote.save
            rescue
              STDERR.puts "Error: failed to save #{vote.id}"
            end
          end
        end
      end
    end

  end

  def parse_php_config(key)
    stdout, stderr, status = Open3.capture3("php -r 'require \"#{@options[:configfile]}\"; print \"$#{key}\";'")
    o = stdout.split("\n")
    if o[0]
      puts "#{key}: #{o[0]}"
      o[0]
    elsif o[1]
      puts "#{key}: #{o[1]}"
      o[1]
    else
      STDERR.puts stderr
      nil
    end
  end
end
