class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { model.from_user },
          recipient: ->(controller, model) { model.to_user },
          params: {
            content: 'content'  # 必要に応じてパラメータを設定
          }
          
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  scope :between_users, -> (user1, user2) do
    where(from_user: user1, to_user: user2).or(where(from_user: user2, to_user: user1))
  end
end
