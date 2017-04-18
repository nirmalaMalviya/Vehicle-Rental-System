class RegistrationsController < Devise::RegistrationsController
	def new
    super
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
	      format.html{redirect_to vehicles_path, notice: 'User is successfully Registered.'}
 	      format.json { render :show, status: :created, location: @my_vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end

  def user_params
    params.require(:user).permit(:sign_up, keys: [:first_name, :last_name, :address, :dob, :roll_type, :name, { images_attributes: [:name, :_destroy] } ])
  end
end
