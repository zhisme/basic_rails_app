# This module unifies rendering error responses.
# It provides high-level methods like `render_not_found` & `render_forbidden`.
# Low-level methods handles different response formats.
module ErrorResponses
  STATUSES = %i[
    bad_request
    forbidden
    not_found
    unauthorized
  ].freeze

  protected

  STATUSES.each do |status|
    define_method "render_#{status}" do |exception = nil|
      render_error_response(status, exception)
    end
  end

  def render_error_response(status, exception)
    respond_to do |format|
      format.html { render_error_response_html(status, exception) }
      format.json { render json: {error: status}, status: status }
      format.js { head status }
    end
  end

  # Render pretty error response with template from `view/errors/`.
  # Secound argument may contain exception object.
  def render_error_response_html(status, _)
    render 'errors/error', layout: 'error', status: status, locals: {status: status}
  end
end
