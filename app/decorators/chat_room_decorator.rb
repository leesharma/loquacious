# Decorates either a single room or a collection of rooms
# for display in the view
class ChatRoomDecorator < BaseDecorator
  attr_reader :url_param

  # Allow the url_param (ex. :room in /dashboard/:room) to be set on initialization
  # Note: nil is an allowed value for url_param (for /dashboard), so the variable
  #       defaults to -1. This allows us to differentiate leaving the default
  #       option and passing in nil.
  #
  # Example:
  #   haskell = ChatRoomDecorator.decorate ChatRoom.create(name: 'haskell')
  #   global  = ChatRoomDecorator.decorate ChatRoom.global
  #
  #   haskell.tagline                         # => 'No description'
  #   dashboard_path(room: haskell.url_param) # => '/dashboard/haskell'
  #   dashboard_path(room: global.url_param)  # => '/dashboard'
  #
  # @param obj [ChatRoom]
  # @param url_param [nil,String] sets the parameter to be used for the url
  # @return [ChatRoomDecorator] decorated chat room
  def initialize(obj, url_param: -1)
    super(obj)
    @url_param = url_param == -1 ? obj.name : url_param
  end

  # Returns true if a join button is needed
  # TODO: include the view context so that this method can generate the button
  # @param current_user [User] the current user, passed in from the view context
  # @return [Boolean] whether a join button is needed
  def join_button?(current_user:)
    !includes_user?(current_user)
  end

  # Returns a user-specified or default chat room tagline
  # @return [String] chat room tagline
  def tagline
    return 'No description' if object.tagline.blank?
    super
  end

  # Returns a decorated collection of associated messages
  # @return [Array<MessageDecorator>]
  def messages(decorator: MessageDecorator)
    @decorated_messages ||= decorator.decorate_collection object.messages
  end
end
