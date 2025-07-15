class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :birth_day, presence: true
  validate :birth_day_must_be_valid_date

  def birth_day_must_be_valid_date
    return if birth_day.blank?
    Date.parse(birth_day)
  rescue ArgumentError
    errors.add(:birth_day, "must be a valid date")
  end

  def formatted_birth_day
    birth_day.strftime("%d/%m/%Y") if birth_day
  end
end
