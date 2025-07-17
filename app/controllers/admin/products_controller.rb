class Admin::ProductsController < Admin::BaseController
  layout "admin"

  def index
    # name = params[:name]

    @products = Product.all
    @products = @products.where(parent_id: nil)
    @products = @products.order(id: :asc)
    @products = @products.page(params[:page]).per(20)

    render "admin/products/index"
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
    @categories = Category.all
    @product_parents = Product.where(parent_id: nil)
    @product_metas = @product.product_metas
    @attributes = Attribute.includes(:attribute_values).all
    debugger
    @form = ::ProductForms::UpdateProductForm.new(
      product: @product,
      sku: @product.sku,
      name: @product.name,
      description: @product.description,
      price: @product.price,
      category_id: @product.category_id,
      stock_quantity: @product.stock_quantity
    )
  end

  def update
    id = params[:id]
    @product = Product.find(id)

    @form = ::ProductForms::UpdateProductForm.new(
      product: @product,
      sku: params[:product_forms_update_product_form][:sku],
      name: params[:product_forms_update_product_form][:name],
      description: params[:product_forms_update_product_form][:description],
      price: params[:product_forms_update_product_form][:price],
      category_id: params[:product_forms_update_product_form][:category_id],
      stock_quantity: params[:product_forms_update_product_form][:stock_quantity]
    )

    if @form.update
      redirect_to admin_products_path, notice: "Product updated successfully."
    else
      render :edit
    end
  end
end
