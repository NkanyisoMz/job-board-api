class ApiController < ApplicationController
    def home
        render json: {
            status: "online",
            message: "Job Board API is running"
        }
    end
end
