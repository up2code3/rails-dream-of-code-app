# frozen_string_literal: true

class MentorEnrollmentAssignment < ApplicationRecord
  belongs_to :mentor
  belongs_to :enrollment
  validates :enrollment, uniqueness: true
end
