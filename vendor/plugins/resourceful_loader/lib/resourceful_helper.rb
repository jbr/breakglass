module ResourcefulHelper
  def render_object_partial(object, options = {})
    singular = object.class.to_s.underscore
    plural = singular.pluralize
    to = options.delete :to
    render_options = {:partial => "#{plural}/#{singular}", :locals => {singular.to_sym => object}.merge(options)}

    if to
      string = controller.send(:render_to_string, render_options)
      to.to_sym == :json ? string.to_json : string
    else
      render render_options
    end
  end
end
