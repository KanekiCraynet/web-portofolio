class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.text :bio
      t.string :avatar
      t.string :tagline
      t.string :github_url
      t.string :linkedin_url
      t.string :twitter_url
      t.integer :role, default: 0, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
