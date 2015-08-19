class UsersController < ApplicationController
  before_action :check_signed_in, only: [:new, :create]

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def check_signed_in
    redirect_to cats_url if signed_in?
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
