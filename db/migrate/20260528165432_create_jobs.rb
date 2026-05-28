class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.string :location
      t.text :description
      t.string :employment_type
      t.string :experience_level
      t.boolean :remote
      t.string :salary_range
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
