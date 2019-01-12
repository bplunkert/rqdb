namespace :chatbot do
  desc 'Run all chatbots'
  task all: [:environment, 'chatbot:discord'] do
  end

  desc 'Run discord chatbots'
  task discord: :environment do

    discord_bots = Chatbot.where(app: 'Discord')
    if discord_bots.count == 0
      exit 0
    else
      require 'discordrb'

      discord_bots.each do |chatbot|
        bot = Discordrb::Commands::CommandBot.new token: chatbot.token, prefix: '!rash '

        bot.command :bottom do |event|
          q = Quote.where(approved: true).order(score: :asc).first
          if q
            q.text
          else
            'No quotes found'
          end
        end

        bot.command :help do |event|
          "Rash Quote DB bot supports the following commands: \n !rash bottom, !rash help, !rash latest, !rash quote TEXT, !rash random, !rash random1, !rash show ID, !rash top"
        end

        bot.command :latest do |event|
          q = Quote.where(approved: true).order(created_at: :desc).first
          if q
            q.text
          else
            'No quotes found'
          end
        end

        bot.command :quote do |_event, *args|
          q = Quote.new(text: args.join(' '), approved: false)
          q.save
          "Submitted quote ##{q.id}: #{q.text}"
        end

        bot.command :random do |event|
          q = Quote.where(approved: true).sample(1).first
          if q
            q.text
          else
            'No quotes found'
          end
        end

        bot.command :random1 do |event|
          q = Quote.where(approved: true).where('score > 0').sample(1).first
            if q
              q.text
            else
              'No quotes found with score > 0'
            end
        end

        bot.command :show do |_event, *args|
          q = Quote.where(id: args.join(' ')).first

          if q.approved == true
            q.text
          else
            "Quote ##{q.id} is pending approval."
          end
        end

        bot.command :top do |event|
          q = Quote.where(approved: true).order(score: :desc).first
          if q
            q.text
          else
            'No quotes found'
          end
        end

        bot.run
      end
    end
  end
end