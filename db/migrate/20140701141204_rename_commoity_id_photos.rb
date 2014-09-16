class RenameCommoityIdPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :commoity_id,:commodity_id
  end
end
