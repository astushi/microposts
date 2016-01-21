class Micropost < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
    has_many :liked_likes, class_name:  "Like",
                                     foreign_key: "liked_id",
                                     dependent:   :destroy
    has_many :liked_users, through: :liked_likes, source: :liker
  
end
