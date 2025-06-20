  class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
    has_many :attendances, dependent: :destroy
    has_many :events, through: :attendances
    has_many :created_events, class_name: "Event", foreign_key: "user_id", dependent: :destroy

    validates :first_name, :last_name, :description, presence: true
    validates :stripe_customer_id, uniqueness: true, allow_nil: true



  def self.find_by_full_name(first_name, last_name)
    where("LOWER(first_name) = ? AND LOWER(last_name) = ?", first_name.downcase.strip, last_name.downcase.strip).first
  end

  def fullname
    "#{first_name} #{last_name}".strip
  end
  end
