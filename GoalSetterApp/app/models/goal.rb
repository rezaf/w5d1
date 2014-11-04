class Goal < ActiveRecord::Base
  validates :body, :user, presence: true
  validates :privacy, inclusion: [true, false]
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :goals
  )
  
end
