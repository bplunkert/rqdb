namespace :legacy do
  desc 'Migrate data from RQMS legacy (Beta 2.0) database and copy to current environment'
  task migrate_database: :environment do
    require 'mysql2'
    require 'optparse'

    options = {}

    o = OptionParser.new do |opts|
      opts.banner = 'Usage: rake legacy:migrate_database [options]'
      opts.on('-h HOST', '--host HOST') { |host| options['host'] = host }
      opts.on('-s SOCKET', '--socket SOCKET') { |socket|  options['socket'] = socket }
      opts.on('-d DATABASE', '--database DATABASE') { |database| options['database'] = database }
      opts.on('-u USERNAME', '--username USERNAME') { |username| options['username'] = username }      
      opts.on('-p PASSWORD', '--password PASSWORD') { |password| options['password'] = password }
      opts.on_tail('--help', 'Show this message') do
        puts opts
        exit
      end
    end

    args = o.order!(ARGV) {}
    o.parse!(args)

    legacy_mysql = Mysql2::Client.new({:host => options['host'], :username => options['username'], :database => options['database'], :password => options['password']})

    legacy_news   = legacy_mysql.query('SELECT * FROM rash_news')
    legacy_queue  = legacy_mysql.query('SELECT * FROM rash_queue')
    legacy_quotes = legacy_mysql.query('SELECT * FROM rash_quotes')

    legacy_news.each do |legacy_announcement|
      puts "Migrating legacy announcement #{legacy_announcement['id']}"
      announcement = Announcement.new(text: legacy_announcement['news'], created_at Time.at(legacy_quote['date'])
      announcement.save
    end

    legacy_queue.each do |legacy_quote|
      puts "Migrating legacy queued quote #{legacy_quote['id']}"      
      quote = Quote.new(text: legacy_quote['quote'], created_at: Time.at(legacy_quote['date'])
      quote.save
    end

    legacy_quotes.each do |legacy_quote|
      puts "Migrating legacy quote #{legacy_quote['id']}"
      is_flagged = case legacy_quote['flag']
        when 1
          true
        else
          false
        end
      quote = Quote.new(text: legacy_quote['quote'], score: legacy_quote['rating'], flagged: legacy_quote['flag'], approved: true, created_at: Time.at(legacy_quote['date'])
      quote.save
    end

  end
end
