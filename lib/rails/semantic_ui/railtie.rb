require 'rails/webpack'
require 'rails'

module Rails::Webpack
  class Railtie < Rails::Railtie
    railtie_name :'rails-semantic-ui'

    rake_tasks do
      load 'tasks/semantic_ui.rake'
    end
  end
end
