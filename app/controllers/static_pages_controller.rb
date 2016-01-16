class StaticPagesController < ApplicationController
  def home
    if logged_in?
        @micropost = current_user.microposts.build if logged_in?
        @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
        @followings = current_user.following_users
        @followings = current_user.following_users
    end
  end
  
  
end
