require "rails_helper"

RSpec.describe "Trimesters deadline", type: :request do
  describe "GET /trimesters/:id/edit" do
    it "shows the application deadline label" do
      trimester = Trimester.create!(term: "Fall", year: 2025, application_deadline: Date.today, start_date: Date.today,end_date: Date.today + 3.months)

      get edit_trimester_path(trimester)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Application deadline")
    end
  end
end