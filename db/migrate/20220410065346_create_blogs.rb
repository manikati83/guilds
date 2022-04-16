class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true
      t.references :guild_blog_tag, null: true, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
