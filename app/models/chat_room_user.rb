class ChatRoomUser < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :chat_room, presence: true
| validates :user, presence: true
end
