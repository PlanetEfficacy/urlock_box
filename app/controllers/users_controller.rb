class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:uid] = @user.id
      redirect_to links_path
    else
      flash[:notice] = @user.errors.full_messages.first
      redirect_to new_registration_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
