module Admin
  class AuthController < ApplicationController
    layout false

    before_action :redirect_if_authenticated, only: [:login, :process_login]

    def login
    end

    def process_login
      @email = params[:email]
      @password = params[:password]

      @user = User.find_by(email: @email)

      if @user&.authenticate(@password)
        session[:user_id] = @user.id
        flash[:success] = "Đăng nhập thành công!"

        redirect_to admin_dashboard_path
      else
        flash.now[:error] = "Tên đăng nhập hoặc mật khẩu không đúng."

        render :login, status: :unprocessable_entity
      end
    end

    def logout
      # handle logout
    end

    def redirect_if_authenticated
      if session[:user_id].present?
        redirect_to admin_dashboard_path, notice: "Bạn đã đăng nhập!"
      end
    end
  end
end
