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
        schema type: :object,
          properties: {
            jobs: {
              type: :array,
              items: {
              type: :object,
              properties: {
                id: { type: :integer },
                title: { type: :string },
                company_name: { type: :string },
                location: { type: :string }
               }
             }
           },
          pagination: {
              type: :object,
              properties: {
                current_page: { type: :integer },
                total_pages: { type: :integer },
                total_count: { type: :integer }
              }
          }
        }

        let(:search) { nil }
        let(:location) { nil }
        let(:employment_type) { nil }
        let(:experience_level) { nil }
        let(:page) { 1 }

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
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            company_name: { type: :string },
            location: { type: :string },
            description: { type: :string }
          }

        example 'application/json', :success, {
          id: 1,
          title: 'Junior Rails Developer',
          company_name: 'Tech Corp',
          location: 'Remote',
          description: 'Rails API development'
       }
       let(:user) do
  User.create!(
    email: 'show@test.com',
    password: 'password123'
  )
end

let(:existing_job) do
  Job.create!(
    title: 'Rails Developer',
    company_name: 'Tech Corp',
    location: 'Remote',
    description: 'Rails API development',
    user: user
  )
end

let(:id) { existing_job.id }

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
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            company_name: { type: :string },
            location: { type: :string }
          }


        let(:user) do
  User.create!(
    email: 'job@test.com',
    password: 'password123'
  )
end

let(:token) do
  JWT.encode(
  { user_id: user.id },
  Rails.application.secret_key_base
)
end

let(:Authorization) { "Bearer #{token}" }

        let(:job) do
          {
            title: 'Junior Rails Developer',
            company_name: 'Tech Corp',
           location: 'Remote'
         }
        end

        run_test!
      end

    response(401, 'unauthorized') do
      let(:Authorization) { nil }

  let(:job) do
    {
      title: 'Test Job',
      company_name: 'Tech Corp',
      location: 'Remote'
    }
  end
  run_test!
end

  response(422, 'validation failed') do
    let(:user) do
      User.create!(
      email: 'job@test.com',
      password: 'password123'
    )
  end

  let(:token) do
    JWT.encode(
      { user_id: user.id },
      Rails.application.secret_key_base
    )
  end

  let(:Authorization) { "Bearer #{token}" }

  let(:job) do
    {
      title: ''
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
      schema type: :object,
        properties: {
          id: { type: :integer },
          title: { type: :string },
          company_name: { type: :string },
          location: { type: :string },
          description: { type: :string }
         }

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
          description: 'Old description',
         user: user
       )
      end

      let(:id) { existing_job.id }

      let(:token) do
  JWT.encode(
  { user_id: user.id },
  Rails.application.secret_key_base
)
      end

let(:Authorization) { "Bearer #{token}" }

      let(:job) do
      {
        title: 'Updated Rails Developer'
      }
      end

      run_test!
    end

    response(401, 'unauthorized') do
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
  let(:Authorization) { nil }

  let(:job) do
    { title: 'Updated' }
  end

  run_test!
end

  response(403, 'forbidden') do
  let(:user) do
    User.create!(
      email: 'owner@test.com',
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

  let(:other_user) do
    User.create!(
      email: 'other@test.com',
      password: 'password123'
    )
  end

  let(:other_token) do
    JWT.encode(
      { user_id: other_user.id },
      Rails.application.secret_key_base
    )
  end

  let(:id) { existing_job.id }   # <-- THIS IS MISSING

  let(:Authorization) { "Bearer #{other_token}" }

  let(:job) do
    { title: 'Updated' }
  end

  run_test!
end
  response(422, 'validation failed') do
  let(:user) do
  User.create!(
    email: 'validation@test.com',
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

let(:token) do
  JWT.encode(
    { user_id: user.id },
    Rails.application.secret_key_base
  )
end

let(:Authorization) { "Bearer #{token}" }

let(:job) do
  {
    title: ''
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

      let(:token) do
        JWT.encode(
          { user_id: user.id },
          Rails.application.secret_key_base
        )
      end

      let(:Authorization) { "Bearer #{token}" }

      run_test!
    end

    response(401, 'unauthorized') do
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

      let(:Authorization) { nil }

      run_test!
    end

    response(403, 'forbidden') do
      let(:user) do
        User.create!(
          email: 'owner@test.com',
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

      let(:other_user) do
        User.create!(
          email: 'other@test.com',
          password: 'password123'
        )
      end

      let(:other_token) do
        JWT.encode(
          { user_id: other_user.id },
          Rails.application.secret_key_base
        )
      end

      let(:id) { existing_job.id }

      let(:Authorization) { "Bearer #{other_token}" }

      run_test!
    end
  end
end
end
