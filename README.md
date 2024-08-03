# README
#テーブル設計

## users テーブル

|Column                  |Type    |Options     |
|------------------------|--------|------------|
|nickname                |string  |null: false |
|email                   |string  |null: false, unique:true |
|encrypted_password      |string  |null: false |
|family_name             |string  |null: false |
|last_name               |string  |null: false |
|family_name_kana        |string  |null: false |
|last_name_kana          |string  |null: false |
|birth_date              |date    |null: false |
|prefecture_id           |integer |null: false |
|gender_identity_id      |integer |null: false |
|sexual_orientation_1_id |integer |null: false |
|sexual_orientation_2_id |integer |null: false |
|sexual_orientation_3_id |integer |null: false |
|sexual_orientation_4_id |integer |null: false |
|sexual_orientation_5_id |integer |null: false |
|sexual_orientation_6_id |integer |null: false |
|sexual_orientation_7_id |integer |null: false |
|height                  |integer |null: false |
|body_type_id            |integer |null: false |
|purpose_id              |integer |null: false |
|self_pr                 |text    |null: false |

  - has_many :chat_room_users
  - has_many :chat_rooms, through: :chat_room_users
  - has_many :messages
  - has_many :likes, foreign_key: :from_user_id
  - has_many :received_likes, class_name: 'Like', foreign_key: :to_user_id

## likes テーブル

|Column             |Type       |Options        |
|-------------------|-----------|---------------|
|from_user_id       |references |null: false, foreign_key: true |
|to_user_id         |references |null: false, foreign_key: true |
|matching           |boolean    |null: false, default: false |

  - belongs_to :from_user, class_name: 'User'
  - belongs_to :to_user, class_name: 'User'


## chat_rooms テーブル
|Column             |Type       |Options  |
|-------------------|-----------|---------|
|created_at	        |datetime   |null: false |
|updated_at	        |datetime   |null: false |

  - has_many :chat_room_users
  - has_many :users, through: :chat_room_users
  - has_many :messages

## chat_room_users テーブル
|Column             |Type       |Options  |
|-------------------|-----------|---------|
|chat_room          |references |null: false, foreign_key: true |
|user               |references |null: false, foreign_key: true |

  - belongs_to :chat_room
  - belongs_to :user

## messages テーブル
|Column             |Type       |Options  |
|-------------------|-----------|---------|
|chat_room          |references |null: false, foreign_key: true |
|user               |references |null: false, foreign_key: true |
|text               |text       |null: false |

  - belongs_to :chat_room
  - belongs_to :user


### Association
- user
  - has_many :chat_room_users
  - has_many :chat_rooms, through: :chat_room_users
  - has_many :messages
  - has_many :likes, foreign_key: :from_user_id
  - has_many :received_likes, class_name: 'Like', foreign_key: :to_user_id


- like
  - belongs_to :from_user, class_name: 'User', foreign_key: :from_user_id
  - belongs_to :to_user, class_name: 'User', foreign_key: :to_user_id


 - chatroom
  - has_many :chat_room_users
  - has_many :users, through: :chat_room_users
  - has_many :messages


- chat_room_user
  - belongs_to :chat_room
  - belongs_to :user


- message
  - belongs_to :chat_room
  - belongs_to :user 
  

