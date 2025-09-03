require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      @current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      @upcoming_trimester = Trimester.create!(
        term: 'Upcoming term',
        year: (Date.today + 6.months).year.to_s,
        start_date: Date.today + 5.months,
        end_date: Date.today + 8.months,
        application_deadline: Date.today + 6.months
      )
      react = CodingClass.create!(title: "React")
      ruby = CodingClass.create!(title: "Ruby on Rails")

      Course.create!(trimester: @current_trimester, coding_class: react)
      Course.create!(trimester: @current_trimester, coding_class: ruby)
      Course.create!(trimester: @upcoming_trimester, coding_class: react)
      Course.create!(trimester: @upcoming_trimester, coding_class: ruby)
    end
    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get "/dashboard"

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include(Date.current.year.to_s)
    end

    it 'displays links to the courses in the current trimester' do
      get "/dashboard"
      expect(response.body).to include("React")
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include((Date.current + 6.months).year.to_s)
    end
    it 'displays links to the courses in the upcoming trimester' do
      get "/dashboard"

      expect(response.body).to include("React")
      expect(response.body).to include("Ruby on Rails")

      upcoming_course_ids = @upcoming_trimester.courses.pluck(:id)

      upcoming_course_ids.each do |id|
        expect(response.body).to include("/courses/#{id}")
      end
    end
  end
end
