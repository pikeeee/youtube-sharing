# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'You have been logged out.'
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Logged in successfully.'
    else
      redirect_to login_path, alert: 'Invalid username or password.'
    end
  end
end
