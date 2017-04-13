class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_many :resumes
  has_many :jobs
  has_many :job_relationships
  has_many :followed_jobs, :through => :job_relationships, :source => :job
  def is_follower?(job)
    followed_jobs.include?(job)
  end
  def follow!(job)
   followed_jobs << job
 end

 def unfollow!(job)
   followed_jobs.delete(job)
 end
end
