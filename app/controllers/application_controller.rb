class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def require_sign_in
    redirect_to new_session_url unless signed_in?
  end

  def sign_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def sign_out
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end
end
