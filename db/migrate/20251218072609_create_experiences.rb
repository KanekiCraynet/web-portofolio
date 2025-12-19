class CreateExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :role
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :location
      t.boolean :current
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
