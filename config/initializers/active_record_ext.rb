class ActiveRecord::Base
  alias_method :_as_json, :as_json

  def self.default_serialization_options
    {}
  end

  def as_json(options = {})
    options = self.class.default_serialization_options.merge(options)
    _as_json(options)
  end
end
