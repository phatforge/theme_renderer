module ThemeRenderer
  module Errors
    class << self; end
  end

  class TRError < StandardError
    def initialize(message=nil)
      super(message)
      @message = message
    end

    #def message
      #@message ||= self.class.to_s
    #end

    #def to_s
      #"[message]: #{message}"
    #end
  end

  class InvalidConfig < TRError
    attr_reader :errors

    def initialize(errors)
      super(errors)
      @errors = errors
    end

    def message
      return
      msg = errors.collect do |key, messages|
        "* #{key}: #{messages.join(', ')}"
      end
      msg.unshift "------"
      msg.unshift "Invalid Configuration"
      msg.join("\n")
    end
  end
end
