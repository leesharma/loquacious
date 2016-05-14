class SessionsController < ApplicationController
  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_by username: username
    if @user && @user.authenticate(password)
      set_current_user @user
      redirect_to root_path, notice: "Hey #{@user.username}, welcome back!"
    else
      render :new
    end
  end

  # DELETE /log_out
  def destroy
    set_current_user(nil)
    redirect_to root_path, notice: 'You have logged out.'
  end

  private

  def username
    params[:username]
  end

  def password
    return unless params[:password] == params[:password_confirmation]
    params[:password]
  end
end
