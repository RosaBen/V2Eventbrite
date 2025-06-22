class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :stripe_customer_id, presence: true, uniqueness: { scope: :event_id }
  after_create :send_new_participant_email

def send_new_participant_email
  UserMailer.new_participant_email(self).deliver_now
end

end
