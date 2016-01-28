# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def edit
    @user = current_user
    render :edit
  end

  def show
    @user = current_user
    render :show
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
