class MyAdminsController < ApplicationController
  before_action :set_my_admin, only: [:show, :edit, :update, :destroy]

  # GET /my_admins
  # GET /my_admins.json
  def index
    @my_admins = MyAdmin.all
  end

  # GET /my_admins/1
  # GET /my_admins/1.json
  def show
  end 

  # GET /my_admins/new
  def new
    @my_admin = MyAdmin.new
  end

  # GET /my_admins/1/edit
  def edit
  end

  # POST /my_admins
  # POST /my_admins.json
  def create
    
    @my_admin = MyAdmin.new(my_admin_params)
   
    respond_to do |format|
      if @my_admin.save
        format.html { redirect_to @my_admin, notice: 'My admin was successfully created.' }
        format.json { render :show, status: :created, location: @my_admin }
      else
        format.html { render :new }
        format.json { render json: @my_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_admins/1
  # PATCH/PUT /my_admins/1.json
  def update
    respond_to do |format|
      if @my_admin.update(my_admin_params)
        format.html { redirect_to @my_admin, notice: 'My admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_admin }
      else
        format.html { render :edit }
        format.json { render json: @my_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_admins/1
  # DELETE /my_admins/1.json
  def destroy
    @my_admin.destroy
    respond_to do |format|
      format.html { redirect_to my_admins_url, notice: 'My admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_admin
      
      @my_admin = MyAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def my_admin_params
      params.require(:my_admin).permit(:name, :age)
    end
end
