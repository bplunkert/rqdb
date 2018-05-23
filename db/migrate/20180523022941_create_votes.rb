class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :quote_id, foreign_key: true
      t.string :ipaddress
      t.integer :value

      t.timestamps
    end
  end
end
