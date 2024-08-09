class Comment < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  scope :between_users, -> (user1, user2) do
    where(from_user: user1, to_user: user2).or(where(from_user: user2, to_user: user1))
  end
end
