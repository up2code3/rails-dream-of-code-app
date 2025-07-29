class CreateLessonTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_topics do |t|
      t.references :topic
      t.references :lesson
      t.timestamps
    end
  end
end
