class SessionsController < ApplicationController
  def new
  end
<<<<<<< HEAD

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
=======
  
  def create

    @user = User.find_by(email: params[:session][:email].downcase)
    
>>>>>>> user-profile
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
<<<<<<< HEAD
  
=======

>>>>>>> user-profile
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
<<<<<<< HEAD
end
=======

end
>>>>>>> user-profile
