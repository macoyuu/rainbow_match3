class ChatRoom < ApplicationRecord
  has_many :chat_room_users
  has_many :users, through: :chat_room_users
  has_many :messages

  validates :created_at, presence: true
  validates :updated_at, presence: true

end
