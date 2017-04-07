class FriendRequestsController < ApplicationController
	load_and_authorize_resource
	before_action :set_request,  except: [:index]

	def index
		byebug
		
		@requests = FriendRequest.where(friend_id: current_user[:id], status: nil)
	end

	def confirm_friend
	  respond_to do |format|
	    if @request.update(status: "confirm")
	      format.html { redirect_to friend_requests_path, notice: 'My admin was successfully created.' }
      end
    end
  end

  def delete_friend
	  respond_to do |format|
	    if @request.destroy
	      format.html { redirect_to friend_requests_path, notice: 'My admin was successfully created.' }
	    end
    end
	end

	private 
	  
	  def set_request
	    @request = FriendRequest.find(params[:id])	
	  end
end
