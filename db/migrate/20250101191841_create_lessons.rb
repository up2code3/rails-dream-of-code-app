# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.integer :lesson_number
      t.string :title
      t.date :assignment_due_date

      t.timestamps
    end
  end
end
