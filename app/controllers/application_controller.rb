class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  protected

  # Returns the user to the sign up page if they aren't logged in
  def authenticate_user!
    redirect_to sign_up_path unless current_user.present?
  end

  private

  # @return [User, nil] the current user if one is set, otherwise nil
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Sets the current user to the passed-in user
  # @param user [User, nil]
  def set_current_user(user)
    session[:user_id] = user.try :id
  end
end
