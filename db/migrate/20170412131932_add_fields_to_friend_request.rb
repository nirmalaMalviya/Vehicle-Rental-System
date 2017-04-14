class AddFieldsToFriendRequest < ActiveRecord::Migration[5.0]
  def change
  	 add_column :friend_requests, :deleted_at, :datetime
    add_index :friend_requests, :deleted_at
  end
end
