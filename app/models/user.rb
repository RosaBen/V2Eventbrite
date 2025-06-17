  class User < ApplicationRecord
    has_many :events, dependent: :destroy
    has_many :attendances, dependent: :destroy
    has_many :event_participants, through: :attendances, source: :event

    validates :first_name, :last_name, :description, presence: true


  def self.find_by_full_name(first_name, last_name)
    where("LOWER(first_name) = ? AND LOWER(last_name) = ?", first_name.downcase.strip, last_name.downcase.strip).first
  end

  def fullname
    "#{first_name} #{last_name}".strip
  end
  end
