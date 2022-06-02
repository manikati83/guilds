class CreateFavoriteGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_galleries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gallery, null: false, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :gallery_id], unique: true
    end
  end
end
