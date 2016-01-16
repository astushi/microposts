class UsersController < ApplicationController
   before_action :validates_user, only: [:edit, :update]
 
  def show
    @user = User.find(params[:id])
    @followings = @user.following_users
    @microposts = @user.microposts.order(created_at: :desc)
  end
    
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to current_user, notice: 'ユーザ情報を更新しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find_by(id: params[:u_id])
    if logged_in?
      @followings = current_user.following_users
    else
      @followings = @user.following_users
    end
  end
  
  def followers
    @user = User.find_by(id: params[:u_id])
    if logged_in?
      @followers = current_user.follower_users
    else
      @followers = @user.follower_users
    end
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
  
  
  def validates_user
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to current_user, notice: '不正なアクセスです'
    end
  end
  
end
