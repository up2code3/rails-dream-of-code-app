# frozen_string_literal: true

class CodingClass < ApplicationRecord
  has_many :courses

  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
end