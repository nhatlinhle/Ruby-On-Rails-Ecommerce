module UserForms
  class CreateUserForm
    include ActiveModel::Model

    attr_accessor :name, :email, :phone_number, :birth_day, :address, :avatar

    validates :name, presence: true
    validates :email, presence: true
    validate :email_must_be_unique
    validates :phone_number, presence: true
    validates :birth_day, presence: true
    validate :birth_day_must_be_valid_date

    def save
      return false unless valid?

      generated_password = SecureRandom.alphanumeric(12)

      ActiveRecord::Base.transaction do
        user = User.new(
          name: name,
          email: email,
          phone_number: phone_number,
          birth_day: birth_day,
          address: address,
          password: generated_password
        )

        user.avatar.attach(avatar) if avatar.present?

        unless user.save
          errors.add(:base, "Could not create user")
          raise ActiveRecord::Rollback
        end

        begin
          UserMailer.with(user: user, password: generated_password).send_password.deliver_now
          puts "✅✅✅✅✅✅✅✅✅ Password email sent to #{user.email}"
        rescue => e
          puts "❌❌❌❌❌❌❌❌❌ Failed to send mail to #{user.email}: #{e.message}"
          errors.add(:base, "Could not send email")
          raise ActiveRecord::Rollback
        end
      end

      errors.empty?
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

      if User.exists?(email: email)
        errors.add(:email, " is already taken")
      end
    end
  end
end
