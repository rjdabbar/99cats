class UsersController < ApplicationController
  def new

  end

  def create
    @user = User.new(user_params[:user_name], user_params[:password])
    if @user.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def show
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
