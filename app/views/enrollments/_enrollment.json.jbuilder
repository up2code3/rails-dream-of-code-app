# frozen_string_literal: true

json.extract! enrollment, :id, :course_id, :student_id, :final_grade, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
