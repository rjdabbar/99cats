class SessionsController < ApplicationController
  before_action :check_signed_in, only: [:new, :create]



  def new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if @user
      sign_in(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to new_session_url
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def check_signed_in
    redirect_to cats_url if signed_in?
  end
end
