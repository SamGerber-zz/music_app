class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :logged_in?

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    current_user
  end

  def logged_out?
    !logged_in?
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["You must be logged in to access this section"]
      redirect_to new_session_url
    end
  end
end
