# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.references :coding_class, null: false, foreign_key: true
      t.references :trimester, null: false, foreign_key: true
      t.integer :max_enrollment

      t.timestamps
    end
  end
end
