module SemanticUi
  class LayoutGenerator < Rails::Generators::Base
    source_root File.expand_path('files', __dir__)
    argument :layout_name, type: :string, default: 'application'

    def overwrite_layout
      copy_file 'layout.slim', "app/views/layout/#{layout_name.underscore}.html.slim", force: true
    end
  end
end
