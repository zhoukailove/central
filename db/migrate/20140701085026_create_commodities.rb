class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.string :title
      t.integer :user_id
      t.boolean :status
      t.integer :commodity_number
      t.integer :orders_count
      t.integer :comments_count

      t.timestamps
    end
  end
end
