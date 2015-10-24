require 'rails/webpack'
require 'rails'

module Rails::SemanticUI
  class Railtie < Rails::Railtie
    railtie_name :'rails-semantic-ui'

    rake_tasks do
      load 'tasks/semantic_ui.rake'
      #load 'tasks/gulp.rake'
      #load 'tasks/npm.rake'
      #load 'tasks/prepare.rake'
      #load 'tasks/webpack.rake'
    end
  end
end
