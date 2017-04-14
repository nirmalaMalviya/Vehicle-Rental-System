class UsersController < ApplicationController
	load_and_authorize_resource
	
  def show
  	#@user = User.find(params[:id])
  end

  def index
    if params[:type] == "friends"
    	@q = current_user.friends.ransack(params[:q])
	    @users = @q.result
	    @users = @users.page(params[:page]).per(1)
	  elsif params[:type] == "non_friends"
	    @q = current_user.non_friends.ransack(params[:q])
	    @users = @q.result
	    @users = @users.page(params[:page]).per(1)
	  else
	  	@q = User.all.ransack(params[:q])
	  	@users = @q.result
	  	@users = @users.page(params[:page]).per(1)
	  end

  end
 

	def add_showing_image
		user = User.find(params[:id])
		respond_to do |format|
			if user.update!(show_image: params[:user][:show_image])
			  format.html{redirect_to user,notice: "Vehicle data successfully updated."}
			else
			  format.html { render :show }
			end
	  end
	end

	def show_friend_request
		@friend = FriendRequest.new(friend_id: params[:id], sender_id: current_user[:id])
		respond_to do |format|
			if @friend.save
			  format.html{redirect_to users_path(type: "non_friends"),notice: "sssssssssssssssss."}
			else
			  format.html { render :show }
			end
	  end
  end

  def userposts  	
  	@users = current_user.friends
  	@vehicles = Vehicle.where(user_id: @users.map(&:id))
  end
end
