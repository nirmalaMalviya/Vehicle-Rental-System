class User < ApplicationRecord
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :images, as: :imageable
  mount_uploader :user_image, AvatarUploader
  accepts_nested_attributes_for :images, reject_if: lambda {|attributes| attributes['name'].blank?}
  has_many :vehicles 
  has_many :book_vehicles
  enum roll_type: [ :admin, :user ]
   
  scope :created_at_day, -> status { where('created_at <= ?', 1.day.ago) unless status.nil? }
  paginates_per 2
  max_paginates_per 50
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def showing_image
    images.where(id: show_image)[0]
  end
  
  def self.by_status(status)
    where('created_at <= ?', 1.day.ago) if status.present?
  end

  def full_name
    (first_name ? first_name : "") + " " + (last_name ? last_name : "")
  end
  
  def friends
    User.where(id: user_friends_ids)
  end

  def non_friends
    User.where.not(id: send_friend_request + user_friends_ids + [id])
  end

  def user_friends_ids
    FriendRequest.where('sender_id = ? OR friend_id = ? AND status = "confirm"', id, id).map {|f| [f.sender_id, f.friend_id] }.flatten - [id]
  end

  def send_friend_request
    FriendRequest.where('sender_id = ? OR friend_id = ? AND status IS ?', id, id, nil).map {|f| [f.sender_id, f.friend_id] }.flatten - [id]
  end





  def self.find_for_oauth(auth, signed_in_resource = nil)
byebug
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          first_name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
#user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

end
