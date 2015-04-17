module Ocioso
  def self.defaults; @defaults; end
  def self.included(base)
    @defaults ||= {}
    base.extend ClassMethods
  end

  def initialize(vars = {}, &block)
    super()
    if h = Ocioso.defaults[self.class]
      vars = h.attributes.merge(vars)
    end
    vars.each do |k, v|
      instance_variable_set "@#{k}", v
    end
    yield(self) if block_given?
  end

  module ClassMethods
    def initialize_defaults(defaults={})
      Ocioso.defaults[self] = DefaultParameters.new defaults
    end
  end

  class DefaultParameters
    attr_reader :attributes
    def initialize(attributes={})
      @attributes = attributes
    end
  end
end