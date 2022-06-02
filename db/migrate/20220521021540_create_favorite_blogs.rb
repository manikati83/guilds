class CreateFavoriteBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_blogs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :blog, null: false, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :blog_id], unique: true
    end
  end
end
