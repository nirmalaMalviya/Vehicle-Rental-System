class Vehicle < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	mount_uploaders :pictures, AvatarUploader
	validates :name, presence: { message: 'Vehicle name can not be empty.'}
	has_many :images, as: :imageable
	accepts_nested_attributes_for :images, reject_if: lambda {|attributes| attributes['name'].blank?}
  belongs_to :user
	has_many :book_vehicles
end
