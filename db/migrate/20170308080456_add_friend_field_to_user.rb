class AddFriendFieldToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :friend_request, :string
  end
end
