class BookVehiclesController < ApplicationController
	load_and_authorize_resource

	def new
		@book_vehicle = BookVehicle.new(vehicle_id: params[:vehicle_id])
	   
	end

	def create
		@book_vehicle = BookVehicle.new(book_vehicle_params)
    respond_to do  |format|
    	if @book_vehicle.save
    		format.html{redirect_to userposts_users_path, notice: 'Vehicle is booked.'}
    	  format.js
    	  UserMailer.welcome_email(current_user).deliver_later
    	else
    	  format.html { render :new }
    	  format.js
    	end	
    end
	end

	def destroy
		@book_vehicle.destroy
    respond_to do |format|
    	format.js
    	format.html{redirect_to userposts_users_path, notice:"Vehicle Booking is successfully Deleted."}
    end
	end

private

  def book_vehicle_params
    params.require(:book_vehicle).permit(:v_cost, :address, :user_id, :vehicle_id, :date_of_booking, :date_of_release)
  end

end
