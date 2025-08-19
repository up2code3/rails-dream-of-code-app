# frozen_string_literal: true

class CreateMentors < ActiveRecord::Migration[8.0]
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :max_concurrent_students

      t.timestamps
    end
  end
end
