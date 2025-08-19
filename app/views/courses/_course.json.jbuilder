# frozen_string_literal: true

json.extract! course, :id, :coding_class_id, :trimester_id, :max_enrollment, :created_at, :updated_at
json.url course_url(course, format: :json)
