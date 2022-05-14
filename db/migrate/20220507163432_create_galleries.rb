class CreateGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :galleries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true
      t.string :photo
      t.text :content

      t.timestamps
    end
  end
end
