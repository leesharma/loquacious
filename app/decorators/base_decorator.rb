require 'delegate'

# Parent class for decorator objects
class BaseDecorator < SimpleDelegator
  # Include helper methods that don't use the view context
  include ActionView::Helpers
  class << self
    # Add method name appropriate to the domain
    alias_method :decorate, :new

    # Decorates each object in a collection of objects
    # @param collection [#map]
    # @return [#map] decorated collection of objects
    def decorate_collection(collection)
      collection.map { |obj| decorate obj }
    end
  end
  # For easier access to the underlying object
  alias_method :object, :__getobj__
end
