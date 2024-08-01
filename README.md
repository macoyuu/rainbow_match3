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

- has_many :messages
- has_many :likes

## likes テーブル

|Column             |Type       |Options        |
|-------------------|-----------|---------------|
|from_user_id       |references |null: false, foreign_key: true |
|to_user_id         |references |null: false, foreign_key: true |
|matching           |boolean    |null: false, default: false |

- belongs_to :user
- has_many :messages

## messages テーブル
|Column             |Type       |Options  |
|-------------------|-----------|---------|
|user               |references |null: false, foreign_key: true |
|text               |text       |null: false |
|like               |references |null: false, foreign_key: true |

- belongs_to :user
- belongs_to :like


### Association
- user
   - has_many :likes
   - has_many :messages

- like
   - belongs_to :user
   - has_many :messages

- message
   - belongs_to :user
   - belongs_to :like
  

