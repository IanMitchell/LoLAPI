module Configuration
  VALID_OPTIONS_KEYS    = [:api_key].freeze

  attr_accessor *VALID_OPTIONS_KEYS

  def reset
    self.api_key = nil
  end

  def configure
    yield self
  end
end
