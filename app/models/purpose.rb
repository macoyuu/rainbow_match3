class Purpose < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '友達探してます' },
    { id: 3, name: '恋活' },
    { id: 4, name: '婚活' },
    { id: 5, name: 'セフレ探してます' },

  ]

  include ActiveHash::Associations
  has_many :users
end