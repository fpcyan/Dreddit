class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])

    unless @user.nil?
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    sign_out!

    redirect_to new_session_url
  end

end
