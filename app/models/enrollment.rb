# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments
end
