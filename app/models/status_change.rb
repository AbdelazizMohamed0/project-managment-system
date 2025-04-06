class StatusChange < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  validates :from_status, presence: true
  validates :to_status, presence: true, inclusion: { in: Project::STATUSES }
  
  default_scope { order(created_at: :desc) }
end
