require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/register' do
    let(:valid_params) do
      {
        email: 'spec@test.com',
        password: 'password123'
      }
    end

    it 'creates a new user' do
      expect {
        post '/api/v1/register', params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'does not create user with invalid data' do
      expect {
        post '/api/v1/register', params: {
          email: '',
          password: ''
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /api/v1/login' do
    let!(:user) do
      User.create!(
        email: 'login@test.com',
        password: 'password123'
      )
    end

    it 'logs in with valid credentials' do
      post '/api/v1/login', params: {
        email: user.email,
        password: 'password123'
      }

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['token']).to be_present
    end

    it 'rejects invalid credentials' do
      post '/api/v1/login', params: {
        email: user.email,
        password: 'wrongpassword'
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
