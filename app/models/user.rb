class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :gender_identity
  belongs_to :sexual_orientation_1
  belongs_to :sexual_orientation_2
  belongs_to :sexual_orientation_3
  belongs_to :sexual_orientation_4
  belongs_to :sexual_orientation_5
  belongs_to :sexual_orientation_6
  belongs_to :sexual_orientation_7
  belongs_to :body_type
  belongs_to :purpose
  has_one_attached :image
  has_many :likes, foreign_key: :from_user_id, class_name: 'Like', dependent: :destroy
  has_many :sent_likes, foreign_key: :from_user_id, class_name: 'Like', dependent: :destroy
  has_many :received_likes, foreign_key: :to_user_id, class_name: 'Like', dependent: :destroy
  has_many :from_comments, class_name: 'Comment', foreign_key: 'from_user_id'
  has_many :to_comments, class_name: 'Comment', foreign_key: 'to_user_id'
  
  
  def liked_by?(user)
    received_likes.where(from_user_id: user.id).exists?
  end

  def matched_with?(other_user)
    Like.exists?(from_user: self, to_user: other_user, matching: true) || 
    Like.exists?(from_user: other_user, to_user: self, matching: true)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true

         PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
         validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角英字と数字の両方を含めて設定してください', on: :create
         

         with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
           validates :family_name
           validates :last_name
         end
       
         with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナを使用してください' } do
           validates :family_name_kana
           validates :last_name_kana
         end
       
         validates :birth_date, presence: true
         validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :gender_identity_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :sexual_orientation_1_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :height, presence: true
         validates :body_type_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :purpose_id, numericality: { other_than: 1, message: "can't be blank" }
         validates :self_pr, presence: true
         validates :image, presence: true
       
         
       
      end
