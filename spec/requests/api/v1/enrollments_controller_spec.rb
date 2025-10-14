# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Enrollments', type: :request, skip: false do
  let!(:current_trimester) do
    Trimester.create!(
      term: 'Term',
      year: 'Year',
      start_date: Date.today - 1.month,
      end_date: Date.today + 2.months,
      application_deadline: Date.today - 1.month,
    )
  end
  let!(:past_trimester) do
    Trimester.create!(
      term: 'Past Term',
      year: 'Past Year',
      start_date: Date.today - 1.year,
      end_date: Date.today - 1.year - 3.months,
      application_deadline: Date.today - 1.year,
    )
  end
  let(:coding_class) do
    CodingClass.create!(
      title: 'Intro to Javascript',
      description: 'Covers JS fundamentals',
    )
  end
  let!(:past_course) do
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: past_trimester.id,
    )
  end
  let!(:current_course) do
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: current_trimester.id,
    )
  end
  let!(:current_student1) do
    Student.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    )
  end
  let!(:current_student2) do
    Student.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    )
  end
  let!(:past_student) do
    Student.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
    )
  end
  let!(:current_enrollment1) do
    Enrollment.create!(
      student_id: current_student1.id,
      course_id: current_course.id,
    )
  end
  let!(:current_enrollment2) do
    Enrollment.create!(
      student_id: current_student2.id,
      course_id: current_course.id,
    )
  end
  let!(:past_enrollment) do
    Enrollment.create!(student_id: past_student.id, course_id: past_course.id)
  end

  describe 'GET /api/v1/courses/:course_id/enrollments' do
    it 'returns a list of enrollments for a specific course' do
      get "/api/v1/courses/#{current_course.id}/enrollments"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['enrollments']).to be_an(Array)
      expect(JSON.parse(response.body)['enrollments'].size).to eq(2)
      expect(
        JSON.parse(response.body)['enrollments'].map { |el| el['id'] },
      ).to eq([ current_student1.id, current_student2.id ])
    end
  end
end
