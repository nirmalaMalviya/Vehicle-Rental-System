class BookVehiclesController < ApplicationController
	load_and_authorize_resource
	before_action :amount_to_be_charged
  before_action :set_description
  before_action :set_plan
  before_action :authenticate_user!

  def jquerywork
  end

  def payment
  end
  
  def stripe_payment
  	
  	customer = Stripe::Customer.create(source: params[:stripeToken])
byebug
Stripe::Charge.create(:customer => customer.id,:amount => params[:amount].to_i,:currency    => 'usd')

    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_book_vehicles_path

  end

  def thanks
  end

	def new
		@book_vehicle = BookVehicle.new(vehicle_id: params[:vehicle_id])
		@vehicle = Vehicle.find_by(id: params[:vehicle_id])
	end

	def create

		@book_vehicle = BookVehicle.new(book_vehicle_params)
    respond_to do  |format|
    	if @book_vehicle.save
    		byebug
    		@v_cost = (( @book_vehicle.date_of_release - @book_vehicle.date_of_booking) / 86400) * @book_vehicle.v_cost
     		format.html{redirect_to userposts_users_path, notice: 'Vehicle is booked.'}
    	  format.js
    	else
    		@vehicle = Vehicle.find_by(id: params[:book_vehicle][:vehicle_id])
    	  format.html { render :new }
    	  format.js
    	end

    
    end
	end

	def show
		@book_vehicle = (BookVehicle.where("date_of_release > ?" , Date.today))
		
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


  def set_description
    @description = "Basic Membership"
  end

  def amount_to_be_charged
    @amount = 2999
  end

  def set_plan
    @plan = 9999
  end

end
