module Responders
  # Basic responder with robust SJR support.
  class Basic < ActionController::Responder
    include Responders::HttpCacheResponder
    include RailsStuff::Responders::Turbolinks

    class InvalidDefaultAction < StandardError; end

    # render action on failures, rediretct on success
    def to_js
      if has_errors?
        return render_basic_js(options[:js_failure]) if options[:js_failure]
      elsif options[:js_success]
        return render_basic_js(options[:js_success])
      end
      begin
        default_render
      rescue ActionView::MissingTemplate => e
        navigation_behavior(e)
      end
    end

    protected

    # Similar to original, but uses render_default_action as method.
    def navigation_behavior(error)
      raise error if get?
      if has_errors? && default_action
        render_default_action
      else
        redirect_to navigation_location
      end
    end

    # Uses shared fallback for js.
    def render_default_action
      render action: default_action
    rescue ActionView::MissingTemplate
      raise unless format == :js
      render_basic_js(:replace_form)
    end

    def render_basic_js(params)
      action, *options = params
      case action
      when :replace_form
        render 'shared/sjr/_replace_form'
      when :replace_content
        controller.render_sjr_replace(*options)
      when :flash_resource_errors
        render 'shared/sjr/_flash_resource_errors'
      when :flash
        render 'shared/sjr/_flash'
      else raise InvalidDefaultAction, action.to_s
      end
    end

    module ControllerHelpers
      def render_sjr_replace(template, **options)
        render template,
          layout: 'find_and_replace',
          formats: [:html],
          content_type: Mime[:js],
          **options
      end
    end

    module Helpers
      module_function

      def flash_to_array(flash)
        types = RailsStuff::Helpers::Bootstrap::BOOTSTRAP_FLASH_TYPE
        flash.map do |type, message|
          {content:  message, style: types[type] || type}
        end
      end
    end
  end
end
