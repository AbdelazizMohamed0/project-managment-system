class BaseService
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  protected

  def current_user
    @user
  end
end 