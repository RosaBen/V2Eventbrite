class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale
  before_action :set_current_user

def set_current_user
  @current_user = User.first # ou User.find(1)
end

def current_user
  @current_user
end
helper_method :current_user


  def set_locale
    I18n.locale = :fr
  end
end
