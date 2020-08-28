module SimpleCommand
  module Utils
    # Borrowed from active_support/core_ext/array/wrap
    def self.array_wrap(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end
  end
end
