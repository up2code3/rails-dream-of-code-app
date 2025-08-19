require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    let!(:student) do
      Student.create(
        first_name: "KJ",
        last_name: "Loving",
        email: "kj@test.com"
      )
    end

    let!(:student2) do
      Student.create(
        first_name: "AJ",
        last_name: "Suning",
        email: "aj@test.com"
      )
    end

    it "returns a page containing all student names" do
      get "/students"
      expect(response.body).to include("Students")
      expect(response.body).to include("First name:")
      expect(response.body).to include("KJ")
      expect(response.body).to include("AJ")
    end
  end
end