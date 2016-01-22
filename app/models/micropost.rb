class Micropost < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :likes

end
