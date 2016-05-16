# Decorates either a single message or a collection of messages
# for display in the view
class MessageDecorator < BaseDecorator
  # Returns the humanized time to be displayed next to a message
  # @return [String]
  def time
    if updated_at < 1.day.ago
      updated_at.to_formatted_s(:day_and_time)
    else
      "#{time_ago_in_words updated_at} ago"
    end
  end
end
