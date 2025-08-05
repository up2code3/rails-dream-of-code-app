class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lesson_topics
  has_many :topics, through: :lesson_topics
end
