class CreateGuildBlogTags < ActiveRecord::Migration[6.0]
  def change
    create_table :guild_blog_tags do |t|
      t.references :guild, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
