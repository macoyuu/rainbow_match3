FactoryBot.define do
factory :user do
  email { Faker::Internet.email }
  password { '1a' + Faker::Internet.password(min_length: 6) }
  password_confirmation { password }
  family_name { '山田' }
  last_name { '一郎' }
  family_name_kana { 'ヤマダ' }
  last_name_kana { 'イチロウ' }
  birth_date { Faker::Date.birthday }
  nickname { Faker::Internet.username }
  prefecture_id { Faker::Number.between(from: 2, to: 48) }
  gender_identity_id { Faker::Number.between(from: 2, to: 7) }
  sexual_orientation_1_id  { Faker::Number.between(from: 2, to: 8) }
  height {Faker::Number.between(from: 140, to: 200) }
  body_type_id {Faker::Number.between(from: 2, to: 6) }
  purpose_id {Faker::Number.between(from: 2, to: 5)}
  self_pr {'よろしくお願いいたします。'}

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
end
end
