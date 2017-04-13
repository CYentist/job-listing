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

end
