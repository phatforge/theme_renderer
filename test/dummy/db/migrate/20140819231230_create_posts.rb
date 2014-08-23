class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :site
      t.string :title
      t.text :body
      t.string :slug

      t.timestamps
    end
    add_index :posts, :site_id
  end
end
