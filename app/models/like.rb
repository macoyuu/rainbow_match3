class Like < ApplicationRecord
  include PublicActivity::Model
   tracked owner: ->(controller, model) { model.from_user },
           recipient: ->(controller, model) { model.to_user }
  
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  has_many :comments

  after_create :check_matching

  def check_matching
    if Like.exists?(from_user_id: self.to_user_id, to_user_id: self.from_user_id)
      self.update(matching: true)
      matching_like = Like.find_by(from_user_id: self.to_user_id, to_user_id: self.from_user_id)
      matching_like.update(matching: true) if matching_like
    end
  end
end
