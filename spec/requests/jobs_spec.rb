require 'swagger_helper'

RSpec.describe 'Jobs API', type: :request do
  path '/api/v1/jobs' do
    get('List jobs') do
      tags 'Jobs'
      produces 'application/json'

      parameter name: :search,
                in: :query,
                type: :string,
                description: 'Search title, company name, or description'

      parameter name: :location,
                in: :query,
                type: :string,
                description: 'Filter by location'

      parameter name: :employment_type,
                in: :query,
                type: :string,
                description: 'Filter by employment type'

      parameter name: :experience_level,
                in: :query,
                type: :string,
                description: 'Filter by experience level'

      parameter name: :page,
                in: :query,
                type: :integer,
                description: 'Page number'

      response(200, 'jobs found') do
        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
    get('Show a job') do
      tags 'Jobs'
      produces 'application/json'

      parameter name: :id,
                in: :path,
                type: :integer,
                description: 'Job ID'

      response(200, 'job found') do
        let(:id) { Job.create!(
          title: 'Swagger Job',
          company_name: 'Tech Corp',
          location: 'Remote',
          user: User.create!(
            email: 'swagger_show@test.com',
            password: 'password123'
          )
        ).id }

        run_test!
      end
    end
  end

  path '/api/v1/jobs' do
  post('Create a job') do
    tags 'Jobs'
    consumes 'application/json'
    produces 'application/json'

    security [ bearerAuth: [] ]

    parameter name: :job,
              in: :body,
              schema: {
                type: :object,
                properties: {
                  title: { type: :string },
                  company_name: { type: :string },
                  location: { type: :string },
                  description: { type: :string },
                  employment_type: { type: :string },
                  experience_level: { type: :string },
                  remote: { type: :boolean },
                  salary_range: { type: :string }
                },
                required: %w[
                  title
                  company_name
                  location
                ]
              }

      response(201, 'job created') do
      response(401, 'unauthorized') do
       run_test!
      end

      response(422, 'validation failed') do
        run_test!
      end
        let(:Authorization) { 'Bearer token' }

        let(:job) do
          {
            title: 'Junior Rails Developer',
            company_name: 'Tech Corp',
            location: 'Remote'
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
  patch('Update a job') do
    tags 'Jobs'
    consumes 'application/json'
    produces 'application/json'

    security [ bearerAuth: [] ]

    parameter name: :id,
              in: :path,
              type: :integer,
              description: 'Job ID'

    parameter name: :job,
              in: :body,
              schema: {
                type: :object,
                properties: {
                  title: { type: :string },
                  company_name: { type: :string },
                  location: { type: :string },
                  description: { type: :string },
                  employment_type: { type: :string },
                  experience_level: { type: :string },
                  remote: { type: :boolean },
                  salary_range: { type: :string }
                }
              }

    response(200, 'job updated') do
    response(401, 'unauthorized') do
      run_test!
    end

    response(403, 'forbidden') do
      run_test!
    end

    response(422, 'validation failed') do
     run_test!
    end
      let(:user) do
        User.create!(
          email: 'update@test.com',
          password: 'password123'
        )
      end

      let(:existing_job) do
        Job.create!(
          title: 'Old Title',
          company_name: 'Tech Corp',
          location: 'Remote',
          user: user
        )
      end

      let(:id) { existing_job.id }

      let(:Authorization) { 'Bearer token' }

      let(:job) do
        {
          title: 'Updated Rails Developer'
        }
        end

        run_test!
      end
    end
  end

  path '/api/v1/jobs/{id}' do
  delete('Delete a job') do
    tags 'Jobs'
    produces 'application/json'

    security [ bearerAuth: [] ]

    parameter name: :id,
              in: :path,
              type: :integer,
              description: 'Job ID'

    response(200, 'job deleted') do

    response(401, 'unauthorized') do
      run_test!
    end

    response(403, 'forbidden') do
      run_test!
    end
      let(:user) do
        User.create!(
          email: 'delete@test.com',
          password: 'password123'
        )
      end

      let(:existing_job) do
        Job.create!(
          title: 'Delete Me',
          company_name: 'Tech Corp',
          location: 'Remote',
          user: user
        )
      end

      let(:id) { existing_job.id }

      let(:Authorization) { 'Bearer token' }

        run_test!
      end
    end
  end
end
