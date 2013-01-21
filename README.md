rake-uglifier
===
A simple rake task for minifying assets and include optional source maps.

Installation
---
```
$ gem install sprockets-helpers
```

Requirements
---
This gem requires the as of now unreleased version of uglifier (2.0).

Install it via their git repo: https://github.com/lautis/uglifier

Setup
---
Here is how you set it up:
```ruby
require 'rake/sprocket_uglifier'

Rake::UglifierTask.new(:minify) do |t|
  root = File.dirname(__FILE__)
  t.assets_path      = File.join(root, 'public', 'assets')
  t.logger           = Logger.new($stdout)
  t.uglifier_options = {
    mangle: {
      except: %w($ zxcvbn jQuery)
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

# A booleaning indicating whether or not to create source maps
:create_source_map

# The path to the root directory where the assets are located.
:assets_path
```

Example Rakefile
---
The Rakefile in the repo is an example of a rakefile that can compile and minify
assets.

License
---
This project is licensed under the MIT license, see LICENSE.txt for more info.
