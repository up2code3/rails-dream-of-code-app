# frozen_string_literal: true

class LessonTopic < ApplicationRecord
  belongs_to :lesson
  belongs_to :topic
end
