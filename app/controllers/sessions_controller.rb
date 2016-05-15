class SessionsController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_by 'lower(username) = ?', params[:username].downcase

    if @user && @user.authenticate(params[:password])
      set_current_user @user
      redirect_to dashboard_path
    else
      render :new
    end
  end

  # DELETE /log_out
  def destroy
    set_current_user(nil)
    redirect_to root_path, notice: 'You have logged out.'
  end
end
