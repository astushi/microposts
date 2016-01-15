class UsersController < ApplicationController
   before_action :validates_user, only: [:edit, :update]
 
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    @page = @user.microposts.page(params[:page])
  end
    
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ようこそ、SAMPLE APPへ"
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
    @followings =  current_user.following_users
  end
  
  def followers
    @followers = current_user.follower_users
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
