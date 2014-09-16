class AddColumnCommoditiesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commodities_count, :integer
  end
end
