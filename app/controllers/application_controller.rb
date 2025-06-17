class ApplicationController < ActionController::Base
  # Devise ajoute automatiquement current_user et user_signed_in? dans les vues
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Pour sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :description ])

    # Pour edit/update
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :description ])
  end

  def set_locale
    I18n.locale = :fr
  end
end
