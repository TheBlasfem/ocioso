module Ocioso
  def initialize(vars = {})
    vars.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end
end