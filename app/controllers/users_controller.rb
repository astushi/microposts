class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update, :show]
 
  def show
    
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
      redirect_to current_user, notice: 'メッセージを保存しました'
    else
      render 'edit'
    end
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
  
  def set_user
  
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to current_user, notice: '不正なアクセスです'
    end
  end
  
end
