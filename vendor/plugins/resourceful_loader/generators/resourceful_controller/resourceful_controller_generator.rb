class ResourcefulControllerGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions "#{class_name}Controller", "#{class_name}ControllerTest", "#{class_name}Helper"

      # Controller, helper, views, and test directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('test/functional', class_path)

      # Controller class, functional test, and helper class.
      m.template 'controller.rb',
                  File.join('app/controllers',
                            class_path,
                            "#{file_name}_controller.rb")

      m.template 'functional_test.rb',
                  File.join('test/functional',
                            class_path,
                            "#{file_name}_controller_test.rb")

      m.template 'helper.rb',
                  File.join('app/helpers',
                            class_path,
                            "#{file_name}_helper.rb")

      {
        %w(_form edit new show index _remote_edit _remote_new _remote_edit) => '.html.haml',
        %w(create destroy update) => '.js.rjs'
      }.each do |views, format|
        views.each do |view|
          view_filename = "#{view}#{format}"
          path = File.join('app/views', class_path, file_name, view_filename)
          m.template File.join("views", view_filename), path
        end
      end
      
      m.template File.join("views", "_object.html.haml"),
        File.join("app/views", class_path, file_name, "_#{file_name.singularize}.html.haml")
    end
  end
end
