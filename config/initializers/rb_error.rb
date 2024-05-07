Rails.configuration.to_prepare do
  class RBError < StandardError
  end

  class RBAuthenticationError < StandardError
  end
end
