class CreateSubmission < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
        t.belongs_to :lesson
        t.belongs_to :enrollment
        t.belongs_to :mentor
        t.string :pull_request_url
        t.string :review_result
        t.datetime :reviewed_at
      t.timestamps
    end
  end
end
