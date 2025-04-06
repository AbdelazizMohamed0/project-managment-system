class Comment < ApplicationRecord
  belongs_to :project, touch: true
  belongs_to :user
  
  validates :content, presence: true
  
  default_scope { order(created_at: :desc) }
end
