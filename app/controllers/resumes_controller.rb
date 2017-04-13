class ResumesController < ApplicationController
before_action :authenticate_user!

  def index
    @resumes = Resume.all
  end

  def new
    @job = Job.find(params[:job_id])
    if current_user.is_follower?(@job)
      @resume = Resume.new
    else
      flash[:alert] = "你还未关注工作"
      redirect_to job_path(@job)
    end

  end

  def show
    @resume = Resume.find(params[:id])
  end

  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      flash[:notice] = "成功提交简历"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])
    @resume = Resume.update(resume_params)
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
  end

  private

  def resume_params
    params.require(:resume).permit(:job_id, :user_id, :content, :attachment)
  end

end
