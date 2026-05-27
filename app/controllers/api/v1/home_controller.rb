class Api::V1::HomeController < Api::V1::BaseController
  def index
    render json: {
      status: "online",
      message: "Job Board API is running"
    }
  end
end