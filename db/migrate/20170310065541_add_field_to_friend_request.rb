class AddFieldToFriendRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :friend_requests, :status, :string
  end
end
