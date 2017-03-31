class BookVehicle < ApplicationRecord
	after_create :send_mail
	belongs_to :user
	belongs_to :vehicle
	validates :address, :date_of_booking, :date_of_release, presence: true
	scope :overlaps, ->(date_of_booking, date_of_release) do
     where "((date_of_booking <= ?) and (date_of_release >= ?))", date_of_booking, date_of_release
  end

  def send_mail
		UserMailer.welcome_email(self.user).deliver_later
	end

  def overlaps?
    overlaps.exists?
  end

  # Others are models to be compared with your current model
  # you can get these with a where for example
  def overlaps
    siblings.overlaps date_of_booking, date_of_release
  end

  validate :not_overlap

  def not_overlap
    errors.add(:key, 'message') if overlaps?
  end

  # -1 is when you have a nil id, so you will get all persisted user absences
  # I think -1 could be omitted, but did not work for me, as far as I remember
  def siblings
    BookVehicle.where('id != ? and vehicle_id = ?', id || -1, vehicle_id)
  end 
end
