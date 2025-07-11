module UserForms
  class CreateUserForm
    include ActiveModel::Model

    attr_accessor :name, :email, :phone_number, :birth_day, :password, :password_confirmation, :address, :avatar

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :phone_number, presence: true
    validates :birth_day, presence: true
    validates :password, presence: true, length: { minimum: 6 }
    validate :birth_day_must_be_valid_date

    def save
      return false unless valid?

      User.create(
        name: name,
        email: email,
        phone_number: phone_number,
        birth_day: birth_day,
        password: password,
        password_confirmation: password_confirmation,
        address: address,
        avatar: avatar
      )
    end

    private

    def birth_day_must_be_valid_date
      return if birth_day.blank?
      Date.parse(birth_day)
    rescue ArgumentError
      errors.add(:birth_day, "must be a valid date")
    end
  end
end
