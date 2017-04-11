class Job < ApplicationRecord
  scope :published, -> { where(is_hidden: false)}

  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_under_bound, presence: true
  validates :wage_under_bound, numericality: { greater_than: 0}

  has_many :resumes
  belongs_to :user


  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end
