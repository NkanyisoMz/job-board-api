# Job Board API

A RESTful Job Board API built with Ruby on Rails.

This project allows users to register, authenticate with JWT, and manage job listings through a secure, documented API. It demonstrates backend development concepts such as authentication, authorization, API design, pagination, filtering, automated testing, and OpenAPI documentation.

---

## Features

### Authentication

- User registration
- User login
- JWT-based authentication
- Protected API endpoints

### Authorization

- Ownership-based access control
- Users can only update or delete jobs they created
- Unauthorized actions return appropriate HTTP status codes

### Job Management

- Create job listings
- View all job listings
- View a single job listing
- Update job listings
- Delete job listings

### Search & Filtering

Search jobs by:

- Title
- Company name
- Description

Filter jobs by:

- Location
- Employment type
- Experience level

### Pagination

- Paginated job listings using Pagy
- Pagination metadata included in API responses

### API Documentation

- Interactive Swagger / OpenAPI documentation using Rswag
- Endpoint descriptions
- Request schemas
- Response schemas
- Authentication documentation

### Error Handling

Centralized API error handling for:

- Record not found errors
- Invalid JWT tokens
- Unauthorized access

### Automated Testing

RSpec request specs covering:

- User registration
- User login
- Job creation
- Authorization rules
- Ownership-based access control
- Job deletion

---

## Tech Stack

### Backend

- Ruby 3.4.8
- Rails 7.1.6
- PostgreSQL

### Authentication

- JWT (JSON Web Tokens)
- bcrypt

### Documentation

- Rswag
- Swagger/OpenAPI 3

### Testing

- RSpec

### Pagination

- Pagy

---

## API Endpoints

### Authentication

| Method | Endpoint | Description |
|----------|----------|-------------|
| POST | `/api/v1/register` | Register a new user |
| POST | `/api/v1/login` | Login and receive JWT token |

### Jobs

| Method | Endpoint | Description |
|----------|----------|-------------|
| GET | `/api/v1/jobs` | List jobs |
| GET | `/api/v1/jobs/:id` | View a job |
| POST | `/api/v1/jobs` | Create a job |
| PATCH | `/api/v1/jobs/:id` | Update a job |
| DELETE | `/api/v1/jobs/:id` | Delete a job |

---

## Authentication

Protected endpoints require a JWT token.

Include the token in the Authorization header:

```http
Authorization: Bearer YOUR_JWT_TOKEN
```

---

## Example Requests

### Register

```http
POST /api/v1/register
```

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

### Login

```http
POST /api/v1/login
```

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

### Create Job

```http
POST /api/v1/jobs
```

```json
{
  "title": "Junior Rails Developer",
  "company_name": "Tech Corp",
  "location": "Remote",
  "description": "Build and maintain Rails APIs",
  "employment_type": "Full-time",
  "experience_level": "Junior",
  "remote": true,
  "salary_range": "R25k-R35k"
}
```

---

## Search & Filtering Examples

Search:

```http
GET /api/v1/jobs?search=rails
```

Filter by location:

```http
GET /api/v1/jobs?location=Remote
```

Filter by employment type:

```http
GET /api/v1/jobs?employment_type=Full-time
```

Filter by experience level:

```http
GET /api/v1/jobs?experience_level=Junior
```

Pagination:

```http
GET /api/v1/jobs?page=2
```

---

## Swagger Documentation

After starting the server, access the interactive API documentation at:

```text
http://localhost:3000/api-docs
```

Swagger allows you to:

- Explore endpoints
- View request and response schemas
- Authenticate with JWT
- Execute API requests directly from the browser

---

## Running Locally

### Clone the Repository

```bash
git clone https://github.com/NkanyisoMz/job_board_api.git
cd job_board_api
```

### Install Dependencies

```bash
bundle install
```

### Setup Database

```bash
rails db:create
rails db:migrate
```

### Start Server

```bash
rails server
```

The API will be available at:

```text
http://localhost:3000
```

---

## Running Tests

Run all tests:

```bash
bundle exec rspec
```

Run specific request specs:

```bash
bundle exec rspec spec/requests
```

---

## Key Concepts Demonstrated

This project demonstrates:

- RESTful API design
- JWT authentication
- Authorization and ownership rules
- PostgreSQL database integration
- Search and filtering
- Pagination
- OpenAPI documentation
- Automated API testing
- Centralized error handling

---

## Future Improvements

Potential enhancements include:

- Rate limiting
- API version expansion
- Advanced search capabilities
- Background jobs
- Admin roles
- Docker support
- CI/CD pipeline integration

---

## Author

**Nkanyiso Mzobe**

Aspiring Backend Developer focused on Ruby on Rails, API development, cloud technologies, DevOps, and secure software engineering.
