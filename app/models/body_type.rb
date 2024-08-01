class BodyType < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '細め' },
    { id: 3, name: '普通' },
    { id: 4, name: 'ぽっちゃり' },
    { id: 5, name: '太め' },
    { id: 6, name: '筋肉質' },
  ]

  include ActiveHash::Associations
  has_many :users
end