require "./lib/ocioso"

Gem::Specification.new do |s|
  s.name              = "ocioso"
  s.version           = Ocioso::VERSION
  s.summary           = "Micro Library for initialize objects"
  s.description       = "Micro Library for initialize objects"
  s.authors           = ["Julio Lopez"]
  s.email             = ["ljuliom@gmail.com"]
  s.homepage          = "http://github.com/TheBlasfem/ocioso"
  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/**/*.rb",
    "*.gemspec",
    "test/**/*.rb"
  ]
  s.license           = "MIT"
  s.add_development_dependency "cutest", "1.1.3"
end