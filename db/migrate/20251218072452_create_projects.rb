class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.text :technologies
      t.string :live_url
      t.string :github_url
      t.boolean :published, default: false, null: false
      t.boolean :featured, default: false, null: false
      t.datetime :published_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :projects, :slug, unique: true
    add_index :projects, :published
    add_index :projects, :featured
  end
end
