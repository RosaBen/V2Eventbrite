class User < ApplicationRecord
  class User < ApplicationRecord
    has_many :events, dependent: :destroy
    has_many :attendances, dependent: :destroy
    has_many :event_participants, through: :attendances, source: :event

    validates :first_name, :last_name, :description, presence: true
  end
end
