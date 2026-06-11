require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/api/v1/register' do
    post('Register a user') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(201, 'user created') do
        schema type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string }
              }
            },
          token: { type: :string }
         }

        let(:user) do
          {
            user: {
              email: 'swagger@test.com',
              password: 'password123'
            }
          }
        end

        run_test!
     end
    end
  end

  path '/api/v1/login' do
    post('Login a user') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(200, 'login successful') do
  let!(:user) do
    User.create!(
      email: 'another@test.com',
      password: 'password123'
    )
  end

  let(:credentials) do
    {
      credentials: {
        email: user.email,
        password: 'password123'
      }
    }
  end

        run_test!
      end
    end
  end
end
