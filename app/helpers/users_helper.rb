module UsersHelper
  def current_user
    @current_user ||= User.first
  end
end
