Gem::Specification.new do |s|
  s.name         = 'rake-uglifier'
  s.version      = '0.0.1'
  s.date         = '2013-01-20'
  s.summary      = "Rake uglifier"
  s.description  = "A rake task for compressing assets with uglifier. It can also create source maps."
  s.authors      = ["Nicklas Ansman"]
  s.email        = 'nicklas@wrapp.com'
  s.files        = ["lib/rake/uglifier_task.rb"]
  s.homepage     = 'http://rubygems.org/gems/rake-uglifier'

  s.add_dependency 'rake'
  s.add_dependency 'uglifier'
end
