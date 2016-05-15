class UsersController < ApplicationController
  # GET /sign_up
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new secure_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Hey #{@user.username}, welcome to loquacio.us!"
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
