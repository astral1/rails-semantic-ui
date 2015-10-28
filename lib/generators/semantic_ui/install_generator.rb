require 'rails/semantic_ui'

module SemanticUi
  class InstallGenerator < Rails::Generators::Base
    include Rails::Webpack::Actions
    source_root File.expand_path('files', __dir__)

    def install_tasks
      copy_file 'semantic-ui.coffee', 'app/webpack/tasks/semantic-ui.coffee'
    end

    def update_dependencies
      dependencies do
        bower 'normalize-css', '~3.0'
        bower 'semantic-ui', '~2.0'

        npm_develop 'file-loader', '~0.8'
        npm_develop 'expose-loader', '~0.7'
      end
    end

#    def add_bower_dependencies
#      template = "\\1#{bower_dependencies.to_s}\n"
#
#      gsub_file 'config/webpack.yml', /(bower:\s*\n(\s+)dependencies:\s*\n)(\s+[^\n]+\n)*/m, template
#    end
#
#    def add_npm_dev_dependencies
#      template = "\\1#{gulp_loaders.to_s}\n"
#
#      gsub_file 'config/webpack.yml', /(npm:\s*\n([-~a-zA-Z0-9\s:'+\/@\.\[\]]+\n)+\s{2}develop_dependencies:\s*\n)(\s{4,}[\s\S]+\n)*/m, template
#    end

    def install_assets
      empty_directory 'app/webpack/src/statics'
      copy_file 'resources/semantic-ui.coffee', 'app/webpack/src/statics/semantic-ui.coffee'
      copy_file 'resources/normalize.coffee', 'app/webpack/src/statics/normalize.coffee'
    end

    def combine_semantic_ui
      inject_into_file 'app/webpack/src/pages/common.coffee', after: "# run webpack pipeline against files in src/pages automatically\n" do 
        "require 'statics/normalize.coffee'\nrequire 'statics/semantic-ui.coffee'\n"
      end
      copy_file 'resources/normalize.coffee', 'app/webpack/src/statics/normalize.coffee'

      inject_into_file 'app/webpack/src/pages/common.coffee', before: " *= require_self\n" do 
        " *= require normailzie\n *= require semantic\n"
      end
    end

    def inject_into_assets
      css = Dir['app/assets/stylesheets/application.*'].first
      js = Dir['app/assets/javascripts/application.*'].first
      js_ext = File.extname js

      pattern = case js_ext
                when 'coffee'
                  "#\n"
                else 'js'
                  "//\n"
                end

      inject_into_file css, after: " *\n" do
        " *= require normalize\n *= require semantic\n"
      end

      inject_into_file js, after: pattern do
        "#= require common.bundle\n"
      end 
    end

    def sync
      rake 'webpack:sync'
    end

    def initial_build
      rake 'npm:install'
      rake 'gulp:webpack'
      rake 'prepare:semantic'
    end

    no_tasks do
      def gulp_loaders
        deps = Rails::SemanticUI::Dependencies.new Rails.configuration.webpack.npm.develop_dependencies
        deps.add('file-loader', '~0.8')
        deps.add('expose-loader', '~0.7')
      end

      def bower_dependencies
        deps = Rails::SemanticUI::Dependencies.new Rails.configuration.webpack.bower.dependencies
        deps.add('normalize-css', '~3.0')
        deps.add('semantic-ui', '~2.0')
      end
    end
  end
end
