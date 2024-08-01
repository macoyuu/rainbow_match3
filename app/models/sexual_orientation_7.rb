class SexualOrientation7 < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '男性' },
    { id: 3, name: '女性' },
    { id: 4, name: 'FtM' },
    { id: 5, name: 'MtF' },
    { id: 6, name: 'FtX' },
    { id: 7, name: 'MtX' },
    { id: 8, name: 'Aセクシャル' },
  ]

  include ActiveHash::Associations
  has_many :users
end