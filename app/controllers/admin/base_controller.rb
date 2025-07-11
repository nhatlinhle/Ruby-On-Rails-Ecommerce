class Admin::BaseController < ApplicationController
  before_action :checkAuthentication

  private def checkAuthentication
    unless session[:user_id].present?
      redirect_to admin_login_path, alert: "Bạn phải đăng nhập!"
    end
  end
end
