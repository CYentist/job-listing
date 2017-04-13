class JobsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :follow, :unfollow]

  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.order('wage_under_bound DESC')
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC')
    else
      Job.published.order("created_at DESC")
    end
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      current_user.follow!(@job)
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to jobs_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy

    redirect_to jobs_path, alert: "删除成功"

  end
  def follow
    @job = Job.find(params[:id])

    if !current_user.is_follower?(@job)
      current_user.follow!(@job)
      flash[:notice] = "关注成功"
    else
      flash[:warning] = "已经关注"
    end

    redirect_to job_path(@job)
  end

  def unfollow
    @job = Job.find(params[:id])

    if current_user.is_follower?(@job)
      current_user.unfollow!(@job)
      flash[:alert] = "成功取消关注"
    else
      flash[:warning] = "您并未关注"
    end
    redirect_to job_path(@job)
  end
  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_under_bound, :contact_email, :is_hidden)
  end

end
