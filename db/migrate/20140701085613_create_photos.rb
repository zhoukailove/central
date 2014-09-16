class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :commoity_id
      t.string :photo
      t.integer :position

      t.timestamps
    end
  end
end
