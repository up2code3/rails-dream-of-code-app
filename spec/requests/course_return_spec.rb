require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe "GET/courses" do
    before do
      # create coding class
      coding_class = CodingClass.create!(title: "Intro to Programming")

      # create coding trimester
      trimester = Trimester.create!(
        term: "Summer",
        year: "2025",
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      # create course
      @course = Course.create!(coding_class: coding_class, trimester: trimester)

      # create student
      student = Student.create!(first_name: "Alice", last_name: "Anderson", email: "alice@example.com")

      # create enrollment
      Enrollment.create!(student: student, course: @course)
    end

    it 'returns a 200 OK status' do
      get "/courses"
      expect(response).to have_http_status(:ok)
    end

    it "displays the course name" do
      get "/courses"
      expect(response.body).to include("Intro to Programming")
    end

    it "displays the student name" do
     get course_path(@course)
     expect(response.body).to include("Alice Anderson")
   end
  end
end
