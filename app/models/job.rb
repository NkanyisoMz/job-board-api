class Job < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :company_name, presence: true
  validates :location, presence: true
end
