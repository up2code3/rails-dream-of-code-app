# frozen_string_literal: true

target_trimester = Trimester.find_by(year: 2025, term: 'Fall')
Course.where(trimester_id: target_trimester.id)
Course.where(trimester_id: Trimester.find_by(year: 2025, term: 'Fall'))
Course.where(trimester_id: 6).pluck(:coding_class_id)
