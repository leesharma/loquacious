class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    redirect_to sign_up_path unless current_user.present?
  end

  private

  # @return [User, nil] the current user if one is set, otherwise nil
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # @param user [User]
  def set_current_user(user)
    session[:user_id] = user.try :id
  end
end
