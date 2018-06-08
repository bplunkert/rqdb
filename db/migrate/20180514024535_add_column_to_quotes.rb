class AddColumnToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :flagged, :boolean
  end
end
