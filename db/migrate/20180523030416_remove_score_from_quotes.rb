class RemoveScoreFromQuotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :quotes, :score, :integer
  end
end
