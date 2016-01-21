class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :age, numericality: {greater_than_or_equal_to: 0},on: :update
    validates :area, length: { maximum: 255 }, on: :update
    has_secure_password
    has_many :microposts
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed   
    
    has_many :follower_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    #他のユーザーをフォローする
    def follow(other_user)
       following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    #フォローしているユーザをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    #あるユーザをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end

     has_many :liking_likes, class_name:  "Like",
                                         foreign_key: "liker_id",
                                         dependent:   :destroy
     has_many :liking_microposts, through: :liking_likes, source: :liked

#いいねをつける
    def like(other_micropost)
        liking_likes.find_or_create_by(liked_id: other_micropost.id)
    end

#いいねをはずす
    def unlike(other_micropost)
        liking_like = liking_likes.find_by(liked_id: other_micropost.id)
        liking_like.destroy if liking_like
    end

 #いいねしているかどうか？
    def like?(other_micropost)
        liking_likes.include?(other_micropost)    
    end

end
