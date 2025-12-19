class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :category
      t.integer :proficiency
      t.string :icon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
