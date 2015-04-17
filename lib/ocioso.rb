module Ocioso
  def initialize(vars = {}, &block)
    vars.each do |k, v|
      instance_variable_set "@#{k}", v
    end
    yield(self) if block_given?
  end
end