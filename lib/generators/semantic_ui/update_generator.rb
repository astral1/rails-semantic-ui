module SemanticUi
  class UpdateGenerator < Rails::Generators::Base
    source_root File.expand_path('files', __dir__)
    argument :layout_name, type: :string, default: 'application'
    class_option :force, type: :boolean, default: false

    def overwrite_layout
      copy_file 'layout.slim', "app/views/layout/#{layout_name.underscore}.html.slim" if options.force?
    end
  end
end
