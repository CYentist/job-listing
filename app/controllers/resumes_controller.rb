class ResumesController < ApplicationController
  def index
    @resume = Resume.all
  end

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
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
