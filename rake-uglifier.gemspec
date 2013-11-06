Gem::Specification.new do |s|
  s.name         = 'rake-uglifier'
  s.version      = '0.0.2'
  s.date         = '2013-11-06'
  s.summary      = "Rake uglifier"
  s.description  = "A rake task for compressing assets with uglifier. It can also create source maps."
  s.authors      = ["Nicklas Ansman"]
  s.homepage     = "https://github.com/wrapp/rake-uglifier"
  s.email        = 'nicklas@ansman.se'
  s.files        = ["lib/rake/uglifier_task.rb"]
  s.homepage     = 'http://rubygems.org/gems/rake-uglifier'
  s.license      = "MIT"

  s.add_dependency 'rake'
  s.add_dependency 'uglifier', '>= 2.0.0'
end
