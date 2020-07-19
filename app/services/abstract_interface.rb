module AbstractInterface

  def self.included(klass)
    klass.send(:include, AbstractInterface::Methods)
    klass.send(:extend, AbstractInterface::Methods)
  end

  module Methods

    def method_not_implemented(klass)
      caller.first.match(/in \`(.+)\'/)
      method_name = $1
      raise MethodNotImplementedException.new("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
    end

  end

end


class MethodNotImplementedException < StandardError
  attr_reader :message
  def initialize(message)
    @message = message
    super()
  end
end
