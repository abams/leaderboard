require 'rack/utils'

module RackMacros
  def last_json
    MultiJson.load(last_response.body)
  end
end
