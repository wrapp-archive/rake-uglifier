require 'rake'
require 'rake/tasklib'
require 'uglifier'

module Rake
  class UglifierTask < Rake::TaskLib
    attr_accessor :uglifier_options
    attr_accessor :name
    attr_accessor :logger
    attr_accessor :assets
    attr_accessor :create_source_map

    attr_reader :assets_path
    def assets_path=(path)
      @assets_path = File.join(path, '')
    end

    def initialize(name=:minify)
      @name              = name
      @logger            = Logger.new($stderr)
      @logger.level      = Logger::INFO
      @uglifier_options  = {}
      @assets            = [/.*\.js/ ]
      @create_source_map = true

      yield self if block_given?

      define
    end

    def define
      desc "#{name.to_s.capitalize} assets"
      task name do
        find_assets do |asset|
          minify_asset(asset)
        end
      end
    end

    def minify_asset(asset)
      path = File.dirname(asset)
      name = File.basename(asset)
      pretty_name = asset.chomp[assets_path.length..-1]

      original_name = "orig-#{name}"
      original_file = File.join(path, original_name)
      pretty_original_name = original_file[assets_path.length..-1]

      source_map_name = name.chomp(File.extname(name)) + ".map"
      source_map_file = File.join(path, source_map_name)

      File.rename(asset, original_file)
      if create_source_map
        logger.debug("Renamed #{pretty_name} -> #{pretty_original_name}")
      end

      uglified = source_map = nil
      ms = benchmark do
        File.open(original_file, 'rb:UTF-8') do |f|
          uglifier = Uglifier.new(uglifier_options.merge(
                                  output_filename: name,
                                  source_filename: original_name))
          if create_source_map
            uglified, source_map = uglifier.compile_with_map(f.read)
          else
            uglified = uglifier.compile(f.read)
          end
        end
      end

      logger.debug("Minified #{pretty_name})  (#{ms}ms)")

      logger.info("Writing #{asset}")
      File.open(asset, 'wb+:UTF-8') do |f|
        f.write(uglified)
        if create_source_map
          f.write("\n//@ sourceMappingURL=#{source_map_name}")
        end
      end

      if create_source_map
        logger.info("Writing #{source_map_file}")
        File.open(source_map_file, 'wb+:UTF-8') do |f|
          f.write(source_map)
        end
      else
        File.delete(original_file)
      end
    end

    private

    def find_assets(path=nil, &block)
      path = assets_path if path == nil
      Dir[File.join(path, '**/*.js')]
        .reject {|f| File.directory?(f) }
        .each do |f|
          assets.each do |asset|
            block.call(f) if asset =~ f
          end
        end
    end

    def benchmark
      start_time = Time.now.to_f
      yield
      ((Time.now.to_f - start_time) * 1000).to_i
    end
  end
end
