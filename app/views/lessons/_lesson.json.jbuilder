# frozen_string_literal: true

json.extract! lesson, :id, :course_id, :lesson_number, :title, :assignment_due_date, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
