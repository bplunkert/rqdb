class AddSubmitteripToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :submitterip, :string
  end
end
