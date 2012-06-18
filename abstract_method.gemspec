# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + "/lib/abstract_method")

Gem::Specification.new do |s|
  s.name        = "abstract_method"
  s.version     = AbstractMethod::VERSION
  s.summary     = "Tiny library enabling you to define abstract methods in Ruby classes and modules"
  s.description = <<-EOT.split("\n").map(&:strip).join(" ")
    Abstract Method is a tiny library enabling you to define abstract methods in
    Ruby classes and modules.
  EOT

  s.author      = "David Majda"
  s.email       = "dmajda@suse.de"
  s.homepage    = "https://github.com/openSUSE/abstract_method"
  s.license     = "MIT"

  s.files       = [
    "LICENSE",
    "README.md",
    "VERSION",
    "lib/abstract_method.rb"
  ]

  s.add_development_dependency "rspec"

  # Minimizing the number of installed gems saves Travis CI machine cycles so
  # let's not include those not really needed in CI environment.
  unless ENV["CI"]
    s.add_development_dependency "redcarpet"
    s.add_development_dependency "yard"
  end
end
