class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :quote, foreign_key: true
      t.string :ipaddress, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
