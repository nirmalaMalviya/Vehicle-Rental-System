class VehiclesController < ApplicationController
  load_and_authorize_resource

  def create
    @vehicle = Vehicle.new(vehicle_params)
		respond_to do |format|
      if @vehicle.save
     		format.html{redirect_to @vehicle, notice: 'Vehicle Information is successfully saved.'}
     		format.json { render :show, status: :created, location: @my_vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  end


  def new
    
    @vehicle.images.new
  end


  def edit
    @vehicle = Vehicle.find(params[:id])
  end


	def show
		@images_urls = @vehicle.images.map(&:name_url).compact
		#@my_image=Image.find(params[:id])
	end


  def update
    respond_to do |format|
    	if @vehicle.update(vehicle_params)
    		format.html{redirect_to @vehicle,notice: "Vehicle data successfully updated."}
    		format.json{render:show, status: :ok, location: @vehicle }
    	else
    		format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
    	end
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    respond_to do |format|
    	format.html{redirect_to vehicles_path, notice:"Vehicle data is successfully Deleted."}
    end
  end

  def vehicleposts
    
    @vehicle = Vehicle.all
    @v = @vehicle.user_friends_ids
    
  end

private
  
  def vehicle_params
    params.require(:vehicle).permit(:name, :vno, :cost, :seater, :fueltype, :created_at, :updated_at, :vtype, :avatar, :pictures, :user_id, images_attributes: [:name, :_destroy])
  end
 
end
