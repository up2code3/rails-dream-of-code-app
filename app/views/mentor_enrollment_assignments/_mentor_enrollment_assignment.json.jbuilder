# frozen_string_literal: true

json.extract! mentor_enrollment_assignment, :id, :mentor_id, :enrollment_id, :created_at, :updated_at
json.url mentor_enrollment_assignment_url(mentor_enrollment_assignment, format: :json)
