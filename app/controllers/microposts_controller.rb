class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = "マイクロポストが作成されました！"
      redirect_to root_url
    else
      flash[:alert] = "マイクロポストの作成に失敗しました！"
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      @micropost = current_user.microposts.build if logged_in?
      @user = current_user
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content,:avatar)
  end
  

end
