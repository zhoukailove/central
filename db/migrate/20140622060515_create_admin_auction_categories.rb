class CreateAdminAuctionCategories < ActiveRecord::Migration
  def change
    create_table :auction_categories do |t|
      t.string :name
      t.integer :level
      t.integer :upid
      t.boolean :status

      t.timestamps
    end
  end
end
