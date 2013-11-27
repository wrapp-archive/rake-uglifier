rake-uglifier
===
A simple rake task for minifying assets and include optional source maps.

Installation
---
```
$ gem install rake-uglifier
```

Setup
---
Here is how you set it up:
```ruby
require 'rake/uglifier_task'

# :minify is the name of the task
Rake::UglifierTask.new(:minify) do |t|
  t.assets_path      = File.join(File.dirname(__FILE__), 'public', 'assets')
  t.logger           = Logger.new($stdout)
  t.uglifier_options = {
    mangle: {
      except: %w($ jQuery someOtherGlobalVariable)
    }
  }
end
```

These are the different options:

```ruby
# A Hash containing the options to give to uglifier
:uglifier_options

# The name of the task, defaults to :minify
:name

# The logger to use
:logger

# A list of regexps that should match any assets to compile
# Defaults to all file ending in .js
:assets

# A list of regexps to ignore
# Default to all minified files
:assets

# A booleaning indicating whether or not to create source maps
:create_source_map

# The path to the root directory where the assets are located.
:assets_path
```

Example Rakefile
---
The [Rakefile](https://github.com/wrapp/rake-uglifier/blob/master/Rakefile) in the repo is an example of a rakefile that can compile and minify
assets.

License
---
This project is licensed under the MIT license, see [LICENSE.txt](https://github.com/wrapp/rake-uglifier/blob/master/LICENSE.txt) for more info.

Changelog
---
 * 0.0.3
   * Add a way to ignore files
 * 0.0.2
   * Minor readme tweaks
   * Require uglifier 2.0
 * 0.0.1
   * Initial release
