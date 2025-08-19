# frozen_string_literal: true

json.extract! coding_class, :id, :title, :description, :created_at, :updated_at
json.url coding_class_url(coding_class, format: :json)
