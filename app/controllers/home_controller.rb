class HomeController < ApplicationController
  layout "front"

  def index
    @title = "Điện máy Hường Trạch"
    @categories = Category.all
  end
end
