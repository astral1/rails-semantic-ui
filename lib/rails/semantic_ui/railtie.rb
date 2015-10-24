require 'rails/semantic_ui'
require 'rails/webpack/railtie'
require 'rails'

module Rails::SemanticUI
  class Railtie < Rails::Railtie
    railtie_name :'rails-semantic-ui'

    rake_tasks do
      load 'tasks/semantic_ui.rake'
    end
  end
end
