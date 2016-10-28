class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
    @user = User.find_by(name: params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.alert = "You dun fucked up, try again"
      render :new
    end
  end

  private

  def sessions_params
    params.require(:user).permit(:name, :password)
  end
end
