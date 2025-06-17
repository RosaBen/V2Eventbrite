  class Event < ApplicationRecord
    belongs_to :user
    has_many :attendances, dependent: :destroy
    has_many :participants, through: :attendances, source: :user

    validates :start_date, presence: true
    validate  :start_date_not_in_the_past

    validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate  :duration_multiple5

    validates :title, presence: true, length: { in: 5..140 }
    validates :description, presence: true, length: { in: 20..1000 }
    validates :price, presence: true, inclusion: { in: 1..1000 }
    validates :location, presence: true

    private

    def start_date_not_in_the_past
      if start_date.present? && start_date < Time.current
        errors.add(:start_date, "date doit être dans le futur")
      end
    end

    def duration_multiple5
      if duration.present? && duration % 5 != 0
        errors.add(:duration, "la durée doit être un multiple de 5")
      end
    end
  end
