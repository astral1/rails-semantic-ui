module SemanticUi
  class InstallGenerator < Rails::Generators::Base
    include Rails::Webpack::Actions
    source_root File.expand_path('files', __dir__)
    class_option :'skip-install', type: :boolean, aliases: :i, desc: 'Skip installation and webpack steps'
    class_option :'skip', type: :boolean, aliases: :s, desc: 'Skip all additional steps. this option implied to set "--skip-install"'

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

    def install_assets
      empty_directory 'app/webpack/src/statics'
      copy_file 'resources/semantic-ui.coffee', 'app/webpack/src/statics/semantic-ui.coffee'
      copy_file 'resources/normalize.coffee', 'app/webpack/src/statics/normalize.coffee'
    end

    def install_scaffold
      empty_directory 'lib/templates/slim/scaffold'
      %w{_form edit index new show}.each do |view|
        copy_file "scaffold/slim/#{view}.html.slim", "lib/templates/slim/scaffold/#{view}.html.slim"
      end
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
                  "#=\n"
                else 'js'
                  "//=\n"
                end

      inject_into_file css, before: " *=\n" do
        " *= require normalize\n *= require semantic\n"
      end

      inject_into_file js, before: pattern do
        "#= require common.bundle\n"
      end 
    end

    def sync
      return if options[:skip]
      rake 'webpack:sync'
    end

    def initial_build
      return if options[:'skip-install'] || options[:skip]
      rake 'npm:install'
      rake 'gulp:webpack'
      rake 'prepare:semantic'
    end
  end
end
