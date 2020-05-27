# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Username or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Logged out!'
  end

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to home_path
  end

  private def auth
    request.env['omniauth.auth']
  end
end
