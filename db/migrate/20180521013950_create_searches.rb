class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.timestamps
      t.string :search_pattern
    end
  end
end
