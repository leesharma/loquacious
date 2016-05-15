require 'delegate'

class MessageDecorator < SimpleDelegator
  class << self
    alias_method :decorate, :new
  end

  def time
    "#{time_ago_in_words updated_at} ago"
  end
end
