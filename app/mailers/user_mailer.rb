class UserMailer < ApplicationMailer
  def send_password
    @user = params[:user]
    @password = params[:password]

    mail(to: @user.email, subject: "Your new account password")
  end
end
