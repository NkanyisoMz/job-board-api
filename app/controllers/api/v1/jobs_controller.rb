class Api::V1::JobsController < Api::V1::BaseController
     before_action :authorize_request, except: [:index, :show]
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    jobs = Job.all

    render json: jobs
  end

  def show
    render json: @job
  end

  def create

    job = current_user.jobs.build(job_params)

    if job.save
      render json: job, status: :created
    else
      render json: {
        errors: job.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @job.user == current_user
      if @job.update(job_params)
        render json: @job
      else
        render json: {
          errors: @job.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: {
        error: "Forbidden"
      }, status: :forbidden
    end
  end

  def destroy
    if @job.user == current_user
      @job.destroy

      render json: {
        message: "Job deleted successfully"
      }
    else
      render json: {
        error: "Forbidden"
      }, status: :forbidden
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.permit(
      :title,
      :company_name,
      :location,
      :description,
      :employment_type,
      :experience_level,
      :remote,
      :salary_range
    )
  end
end
