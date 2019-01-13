class CreateChatbots < ActiveRecord::Migration[5.2]
  def change
    create_table :chatbots do |t|
      t.string :app, null: false
    t.string :token, null: false
    end
  end
end
