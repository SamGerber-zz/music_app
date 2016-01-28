class SessionsController < ApplicationController

  def new
    @disable_nav_pill = true
    render :new
  end

  def create
    @user = User.find_by_credentials(
              email: params[:user][:email],
              password: params[:user][:password]
            )
    if @user
      log_in!(@user)
      flash[:notifications] = ["Hello, #{@user.email}! Welcome back to Music!"]
      redirect_to user_url(@user)
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
