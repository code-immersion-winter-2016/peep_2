class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :realtionships
  has_many :friends, through: :relationships

  validates :name , presence: true
  validates :username , presence: true , uniqueness: true

  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_relationships, source: :user

  has_many :likes

  def likes?(tweet)
    tweet.likes.where(user_id: id).any?
  end
end
