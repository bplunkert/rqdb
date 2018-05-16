class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :text, null: false
      t.integer :score, default: 0, null: false
      t.boolean :approved, default: false, null: false

      t.timestamps
    end
  end
end
