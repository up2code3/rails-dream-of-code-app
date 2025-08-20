require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context "when mentors exist" do
      before do
        Mentor.create!(first_name: "Mike", last_name: "Tyson", email: "punchout@mail.com")
        Mentor.create!(first_name: "Roy", last_name: "Jones", email: "Boxer@mail.com")
      end

      it "returns all mentors" do
        get "/mentors"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Mentors")
        expect(response.body).to include("Email")
        expect(response.body).to include("First name:")
      end
    end

    context "when mentor does not exist" do
      it "still shows h1 Mentors but no attributes" do   # ✅ FIXED: wrapped in `it`
        get "/mentors"
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include("First name:")
      end                                                # ✅ FIXED: matching end
    end
  end

  describe "GET /mentors/:id" do
    before do
      @mentor1 = Mentor.create!(first_name: "Mike", last_name: "Tyson", email: "punchout@mail.com")
    end

    it "returns a single mentor by id" do
      get "/mentors/#{@mentor1.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Email")
      expect(response.body).to include("Mike")
      expect(response.body).to include("Tyson")
    end
  end
end
