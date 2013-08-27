# Tiny library enabling you to define abstract methods in Ruby classes and
# modules.
module AbstractMethod
  # Abstract Method version (uses [semantic versioning](http://semver.org/)).
  VERSION = File.read(File.dirname(__FILE__) + "/../VERSION").strip
end

# Exception raised when an abstract method is called.
class AbstractMethodCalled < StandardError
end

class Module
  # Defines one or more abstract methods with given names in a class or module.
  # When called, the abstract method will raise an `AbstractMethodCalled`
  # exception with a helpful message.
  #
  # @example
  #   class AbstractClass
  #     abstract_method :foo
  #   end
  #
  #   class ConcreteClass < AbstractClass
  #     def foo
  #       42
  #     end
  #   end
  #
  #   AbstractClass.new.foo # raises AbstractMethodCalled
  #   ConcreteClass.new.foo # => 42
  #
  # @param [Array<Symbol>] names the names of defined abstract methods
  def abstract_method(*names)
    definitor = self

    names.each do |name|
      define_method name do |*args|
        raise AbstractMethodCalled,
              "Called unimplemented abstract method #{self.class}##{name} " +
              "(defined in #{definitor.class.name.downcase} #{definitor})."
      end
    end
  end
end
