# frozen_string_literal: true

class CreateMentorEnrollmentAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_enrollment_assignments do |t|
      t.references :mentor, null: false, foreign_key: true
      t.references :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
