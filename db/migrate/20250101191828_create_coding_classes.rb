# frozen_string_literal: true

class CreateCodingClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :coding_classes do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
