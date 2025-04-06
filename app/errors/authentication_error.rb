class AuthenticationError < StandardError
  def initialize(message = 'Authentication failed')
    super(message)
  end
end 