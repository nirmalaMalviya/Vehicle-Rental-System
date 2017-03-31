class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images, as: :imageable
  mount_uploader :user_image, AvatarUploader
  accepts_nested_attributes_for :images, reject_if: lambda {|attributes| attributes['name'].blank?}
  has_many :vehicles 
  has_many :book_vehicles
  enum roll_type: [ :admin, :user ]
  
  def showing_image
    images.where(id: show_image)[0]
  end

  def full_name
    (first_name ? first_name : "") + " " + (last_name ? last_name : "")
  end
  
  def friends
    User.where(id: user_friends_ids)
  end

  def non_friends
    User.where.not(id: send_friend_request + user_friends_ids)
  end

  def user_friends_ids
    FriendRequest.where('sender_id = ? OR friend_id = ? AND status = "confirm"', id, id).map {|f| [f.sender_id, f.friend_id] }.flatten - [id]
  end

  def send_friend_request
    FriendRequest.where('sender_id = ? OR friend_id = ? AND status = NULL', id, id).map {|f| [f.sender_id, f.friend_id] }.flatten - [id]
  end

end
