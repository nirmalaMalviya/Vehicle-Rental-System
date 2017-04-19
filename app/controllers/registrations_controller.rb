class RegistrationsController < Devise::RegistrationsController
	def new
    build_resource({})
    resource.roll_type = params["role_type"]
    yield resource if block_given?
    respond_with resource
  end

  def user_params
    params.require(:user).permit(:sign_up, keys: [:first_name, :last_name, :address, :dob, :roll_type, :name, { images_attributes: [:name, :_destroy] } ])
  end
end
