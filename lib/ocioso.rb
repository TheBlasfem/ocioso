module Ocioso
  def self.defaults; @defaults; end
  def self.values_allowed; @values_allowed; end
  def self.included(base)
    @defaults ||= {}; @values_allowed ||= {}
    base.extend ClassMethods
  end

  def initialize(vars = {}, &block)
    super()
    if h = Ocioso.defaults[self.class]
      vars = h.attributes.merge(vars)
    end
    vars.each do |k, v|
      if Ocioso.values_allowed[self.class]
        if Ocioso.values_allowed[self.class].include? k
          instance_variable_set "@#{k}", v
        end
      else
        instance_variable_set "@#{k}", v
      end
    end
    yield(self) if block_given?
  end

  module ClassMethods
    def initialize_defaults(defaults={})
      Ocioso.defaults[self] = DefaultParameters.new defaults
    end

    def initialize_only_with(*args)
      Ocioso.values_allowed[self] = args
    end
  end

  class DefaultParameters
    attr_reader :attributes
    def initialize(attributes={})
      @attributes = attributes
    end
  end
end