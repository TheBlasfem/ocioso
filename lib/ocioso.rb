module Ocioso
  class << self
    attr_reader :defaults, :values_allowed
  
    def included(base)
      @defaults ||= {}; @values_allowed ||= {}
      base.extend ClassMethods
    end

    def get_values(klass)
      [values_allowed[klass], defaults[klass]]
    end
  end

  def initialize(vars = {}, &block)
    super()
    _a, _h = Ocioso.get_values(self.class)
    vars = _h.attributes.merge(vars) if _h
    vars.each do |k, v|
      instance_variable_set "@#{k}", v if (_a && _a.include?(k) || _a.nil? )
    end
    yield self if block_given?
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