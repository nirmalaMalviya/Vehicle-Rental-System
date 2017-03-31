class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    
    #redirect_back, :alert => exception.message
     respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_back, alert = exception.message }
    end

  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :dob, :roll_type, :name, { images_attributes: [:name, :_destroy] } ])
  end
end
