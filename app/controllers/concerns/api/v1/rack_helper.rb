module Api::V1::RackHelper
  def render_error type, options = {}
    if options.is_a?(String)
      options = { description: options }
    end

    body = { error: (options[:type] || type) }
    body[:error_description] = options[:description] if options[:description]

    render json: body, status: type
  end
end
