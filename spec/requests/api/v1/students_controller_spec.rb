# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request, skip: false do
  describe 'POST /api/v1/students' do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    let(:invalid_attributes) do
      {
        student: {
          first_name: '',
          last_name: '',
          email: ''
        }
      }
    end

    it 'creates a new student' do
      expect do
        post '/api/v1/students', params: valid_attributes
      end.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq('validstudent@example.com')
    end

    it 'does not create a student with invalid params' do
      expect do
        post '/api/v1/students', params: invalid_attributes
      end.not_to change(Student, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("First name can't be blank")
    end
  end
end
