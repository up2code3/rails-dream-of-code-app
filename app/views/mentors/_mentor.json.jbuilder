# frozen_string_literal: true

json.extract! mentor, :id, :first_name, :last_name, :email, :max_concurrent_students, :created_at, :updated_at
json.url mentor_url(mentor, format: :json)
