# frozen_string_literal: true

json.array! @lessons, partial: "lessons/lesson", as: :lesson
