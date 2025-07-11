class Admin::AdminController < Admin::BaseController
  layout "admin"

  def dashboard
    render "admin/dashboard"
  end
end
