class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to users_url
    else
      flash[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end
  
  private
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  private
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
