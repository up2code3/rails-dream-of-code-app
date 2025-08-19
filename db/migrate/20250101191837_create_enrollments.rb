# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.string :final_grade

      t.timestamps
    end
  end
end
