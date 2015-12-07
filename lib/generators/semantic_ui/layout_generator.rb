module SemanticUi
  class LayoutGenerator < Rails::Generators::Base
    source_root File.expand_path('files', __dir__)
    argument :layout_name, type: :string, default: 'application'
    class_option :force, type: :boolean, default: false, aliases: :f

    def overwrite_layout
      copy_file 'layout.slim', "app/views/layouts/#{layout_name.underscore}.html.slim", force: options[:force]
    end
  end
end
