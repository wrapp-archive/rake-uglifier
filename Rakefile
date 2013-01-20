require './app'
require 'rake/sprocketstask'
require 'rake/uglifier_task'
require 'logger'

namespace :assets do
  logger       = Logger.new($stdout)
  logger.level = Logger::DEBUG

  task :precompile => [:clean, :compile, :minify]

  Rake::SprocketsTask.new(:compile) do |t|
    t.environment = App.sprockets
    t.output      = App.assets_path
    t.assets = %w{
      *.js
      *.css
      *.png
      *.ico
      *.gif
      *.jpg}
    t.logger = logger
  end

  task :clean do
    logger.info("Cleaning assets")
    FileUtils.rm_rf(App.assets_path)
  end


  Rake::UglifierTask.new(:minify) do |t|
    t.assets_path      = App.assets_path
    t.logger           = logger
    t.uglifier_options = {
      mangle: {
        except: %w($ jQuery)
      }
    }
  end
end
