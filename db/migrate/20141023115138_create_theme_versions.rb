class CreateThemeVersions < ActiveRecord::Migration
  def change
    create_table :theme_versions do |t|
      t.integer :version
      t.string :sha
      t.references :theme
      t.timestamps
    end
  end
end
