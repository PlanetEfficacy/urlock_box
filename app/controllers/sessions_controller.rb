class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email]).authenticate(params[:user][:password])
    if @user
      session[:uid] = @user.id
      redirect_to links_path
    else
      flash[:danger] = "Incorrect email or password."
      redirect_to login_path
    end
  end



end
