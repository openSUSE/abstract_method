require "spec_helper"

describe Module do
  describe "abstract_method" do
    RSpec::Matchers.define :have_abstract_method do |name|
      match do |object|
        next false unless object.respond_to?(name)

        begin
          object.send(name)
          false
        rescue AbstractMethodCalled
          true
        end
      end
    end

    class AbstractClass
      abstract_method :foo
    end

    class AbstractClassChild < AbstractClass
    end

    module AbstractModule
      abstract_method :foo
    end

    class AbstractModuleIncluder
      include AbstractModule
    end

    describe "when used in a class" do
      it "defines an abstract method in the class where it's called" do
        AbstractClass.new.should have_abstract_method(:foo)
      end

      it "defines an abstract method in a subclass of that class" do
        AbstractClassChild.new.should have_abstract_method(:foo)
      end
    end

    describe "when used in a module" do
      it "defines an abstract method in a class including that module" do
        AbstractModuleIncluder.new.should have_abstract_method(:foo)
      end
    end

    it "allows defining multiple abstract methods" do
      class MultiAbstractClass
        abstract_method :foo, :bar, :baz
      end

      MultiAbstractClass.new.should have_abstract_method(:foo)
      MultiAbstractClass.new.should have_abstract_method(:bar)
      MultiAbstractClass.new.should have_abstract_method(:baz)
    end

    describe "created method" do
      it "raises an exception with correct message when defined in a class" do
        lambda {
          AbstractClassChild.new.foo
        }.should raise_error(
          AbstractMethodCalled,
          "Called unimplemented abstract method AbstractClassChild#foo (defined in class AbstractClass)."
        )
      end

      it "raises an exception with correct message when defined in a module" do
        lambda {
          AbstractModuleIncluder.new.foo
        }.should raise_error(
          AbstractMethodCalled,
          "Called unimplemented abstract method AbstractModuleIncluder#foo (defined in module AbstractModule)."
        )
      end
    end
  end
end
