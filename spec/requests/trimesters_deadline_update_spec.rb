require "rails_helper"

RSpec.describe "Trimesters deadline update", type: :request do
  describe "PUT /trimesters/:id" do
    let!(:trimester) do
      Trimester.create!(
        term: "Fall",
        year: 2025,
        start_date: Date.today,
        end_date: Date.today + 3.months,
        application_deadline: Date.today
      )
    end
    #1
     it "updates the application deadline when given a valid date" do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: Date.today + 1.week }
      }

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      #My Flash Notice Alert check Grn Red messages
      expect(response.body).to include("Application deadline updated successfully.")
      #Persist to Database check 
      expect(trimester.reload.application_deadline).to eq(Date.today + 1.week)
    end

       it "returns bad_request when no application_deadline is provided" do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: "" }
      }

      expect(response).to have_http_status(:bad_request)
    end

        it "returns bad_request when application_deadline is not a valid date" do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: "not-a-date" }
      }

      expect(response).to have_http_status(:bad_request)
    end

        it "returns not_found when trimester does not exist" do
      put trimester_path(-1), params: {
        trimester: { application_deadline: Date.today + 1.week }
      }

      expect(response).to have_http_status(:not_found)
    end

  end
end