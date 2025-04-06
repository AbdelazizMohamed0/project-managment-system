class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :users, through: :comments
  
  STATUSES = ['Not Started', 'In Progress', 'On Hold', 'Completed', 'Cancelled'].freeze
  
  validates :name, presence: true
  validates :description, presence: true
  validates :current_status, presence: true, inclusion: { in: STATUSES }

  before_create :set_initial_status
  

  private

  def set_initial_status
    self.current_status ||= 'Not Started'
  end
end
