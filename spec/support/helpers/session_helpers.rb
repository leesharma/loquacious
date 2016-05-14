module Features
  module SessionHelpers
    # Sets the current user
    # @param user [User] user to login
    def login_as(user)
      session[:user_id] = user.id
    end
  end
end
