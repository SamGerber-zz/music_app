class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def edit
    @user = current_user
    render :edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      flash[:notifications] = ["Hello, #{@user.email}! Welcome to Music!"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages

      render :new
    end
  end


  protected

  def user_params
    params.require(:user).permit(:email, :password, :session_token)
  end
end
