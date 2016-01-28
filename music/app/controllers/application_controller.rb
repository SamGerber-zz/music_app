class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    session[:session_token] = nil
    current_user.session_token = nil
    current_user.save!
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
end
