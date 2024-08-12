class Notification < ApplicationRecord
  acts_as_readable on: :created_at
  belongs_to :user
  belongs_to :trackable, polymorphic: true
end
