class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :enrollment
  belongs_to :mentor
end
