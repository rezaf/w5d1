class Goal < ActiveRecord::Base
  validates :body, :privacy, :user_id, presence: true
  
  belongs_to :user
  
end
