class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true, with: :exception
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
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

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user), notice: 'Please finish your sign up.'
    end
  end
end
