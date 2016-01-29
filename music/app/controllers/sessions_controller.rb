class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @disable_nav_pill = true
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!(@user)
      flash[:notifications] = ["Hello, #{@user.email}! Welcome back to Music!"]
      redirect_to bands_url
    else
      flash.now[:errors] = ["Sorry, invalid credentials. Please try again."]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end


end
