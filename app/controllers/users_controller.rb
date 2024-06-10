# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
