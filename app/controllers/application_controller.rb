class ApplicationController < ActionController::API
    include Pagy::Backend

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    rescue_from JWT::DecodeError, with: :invalid_token

    private

    def record_not_found(_exception)
      render json: {
        error: "Resource not found"
      }, status: :not_found
    end

    def invalid_token
      render json: {
        error: "Invalid token"
    }, status: :unauthorized
    end

end
