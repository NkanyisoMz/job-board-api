require 'rails_helper'

RSpec.describe 'Api::V1::Jobs', type: :request do
  let!(:user) do
    User.create!(
      email: 'jobs@test.com',
      password: 'password123'
    )
  end

  let!(:other_user) do
    User.create!(
      email: 'other@test.com',
      password: 'password123'
    )
  end

  let!(:job) do
    Job.create!(
      title: 'Junior Rails Developer',
      company_name: 'Tech Corp',
      location: 'Remote',
      user: user
    )
  end

  describe 'GET /api/v1/jobs' do
    it 'returns jobs successfully' do
      get '/api/v1/jobs'

      expect(response).to have_http_status(:ok)
    end
  end

  let(:token) do
    JWT.encode(
      { user_id: user.id },
      Rails.application.secret_key_base
    )
  end

  let(:other_token) do
    JWT.encode(
      { user_id: other_user.id },
      Rails.application.secret_key_base
    )
  end

  describe 'POST /api/v1/jobs' do
    let(:valid_attributes) do
      {
        title: 'Backend Developer',
        company_name: 'New Company',
        location: 'Remote'
      }
    end

    it 'creates a job for an authenticated user' do
      expect {
        post '/api/v1/jobs',
            params: valid_attributes,
            headers: {
              'Authorization' => "Bearer #{token}"
            }
      }.to change(Job, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /api/v1/jobs/:id' do
    it 'prevents another user from updating the job' do
      patch "/api/v1/jobs/#{job.id}",
          params: {
            title: 'Hacked Title'
          },
          headers: {
            'Authorization' => "Bearer #{other_token}"
          }

      expect(response).to have_http_status(:forbidden)
    end

    it 'allows the owner to update the job' do
      patch "/api/v1/jobs/#{job.id}",
        params: {
          title: 'Updated Title'
        },
        headers: {
          'Authorization' => "Bearer #{token}"
        }

      expect(response).to have_http_status(:ok)

      expect(job.reload.title).to eq('Updated Title')
    end
  end

  describe 'DELETE /api/v1/jobs/:id' do
    it 'prevents another user from deleting the job' do
      expect {
        delete "/api/v1/jobs/#{job.id}",
             headers: {
               'Authorization' => "Bearer #{other_token}"
             }
      }.not_to change(Job, :count)

      expect(response).to have_http_status(:forbidden)
    end

    it 'allows the owner to delete the job' do
      expect {
        delete "/api/v1/jobs/#{job.id}",
             headers: {
               'Authorization' => "Bearer #{token}"
             }
      }.to change(Job, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
