module UserForms
  class UpdateUserForm
    include ActiveModel::Model

    attr_accessor :user, :name, :email, :phone_number, :birth_day, :address, :avatar

    validates :name, presence: true
    validates :email, presence: true
    validate :email_must_be_unique
    validates :phone_number, presence: true
    validates :birth_day, presence: true
    validate :birth_day_must_be_valid_date

    def update
      return false unless valid?

      user.name = name
      user.email = email
      user.phone_number = phone_number
      user.birth_day = birth_day
      user.address = address

      if avatar.present?
        user.avatar.attach(avatar)
      end

      user.save
    end

    private

    def birth_day_must_be_valid_date
      return if birth_day.blank?
      Date.parse(birth_day)
    rescue ArgumentError
      errors.add(:birth_day, "must be a valid date")
    end

    def email_must_be_unique
      return if email.blank?

      existing_user = User.where(email: email).where.not(id: user.id).first
      if existing_user
        errors.add(:email, " is already taken")
      end
    end
  end
end
