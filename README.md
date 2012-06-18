Abstract Method
===============

Abstract Method is a tiny library enabling you to define abstract methods in
Ruby classes and modules.

Example
-------

```ruby
class AbstractClass
  abstract_method :foo
end

class ConcreteClass < AbstractClass
  def foo
    42
  end
end

AbstractClass.new.foo # raises AbstractMethodCalled
ConcreteClass.new.foo # => 42
```

Installation
------------

    $ gem install abstract_method

Usage
-----

First, require the library:

```ruby
require "abstract_method"
```

You can now use the `abstract_method` method to define abstract methods in
classes and modules.

```ruby
class AbstractClass
  abstract_method :foo
end

class AbstractModule
  abstract_method :bar
end
```

When called, the abstract method will raise an `AbstractMethodCalled` exception
with a helpful message:

```ruby
AbstractClass.new.foo # raises AbstractMethodCalled with the following message:
                      #   Called unimplemented abstract method AbstractClass#foo
                      #   (defined in class AbstractClass).
```

Abstract methods can be overridden as usual:

```ruby
class ConcreteClass < AbstractClass
  def foo
    42
  end
end

ConcreteClass.new.foo # => 42
```

For more information, see the [API
documentation](http://rubydoc.info/github/openSUSE/abstract_method/frames).

FAQ
---

**Why define abstract methods? In a dynamic language like Ruby they aren't
needed.**

Mainly for documentation purposes. The definitions allow subclass authors to
easily see what they need to implement. They are also a great place to attach
documentation.

**Why create a new library? There is already the
[abstract](http://rubygems.org/gems/abstract) gem.**

With the abstract gem you have to specify the abstract method parameter list in
a string when you define it. This is ugly and in Ruby the parameter list often
does not say much about the method anyway. The parameters should should rather
be described using a code documentation system (such as
[YARD](http://yardoc.org/)).
