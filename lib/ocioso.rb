# Copyright (c) 2015 Julio Lopez

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
module Ocioso
  VERSION = "1.0.1"
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
    _a, _d = Ocioso.get_values(self.class)
    vars = _d.attributes.merge(vars) if _d
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