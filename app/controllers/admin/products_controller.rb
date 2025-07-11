class Admin::ProductsController < Admin::BaseController
  layout "admin"

  def index
    render "admin/products/index"
  end
end
