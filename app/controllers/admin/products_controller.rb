class Admin::ProductsController < Admin::BaseController
  require "ostruct"
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

    @attribute_grouped = @product
      .product_attribute_values
      .includes(:attribute_record)
      .map(&:attribute_record)
      .uniq
      .index_with do |attribute|
        attribute.attribute_values.map do |val|
          {
            id: val.id,
            name: val.name,
            attribute_id: attribute.id
          }
        end
      end

    @existing_value_ids = @product.product_attribute_values.pluck(:attribute_value_id)

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
    # binding.pry
    # id = params[:id]
    # @product = Product.find(id)

    # @form = ::ProductForms::UpdateProductForm.new(
    #   product: @product,
    #   sku: params[:product_forms_update_product_form][:sku],
    #   name: params[:product_forms_update_product_form][:name],
    #   description: params[:product_forms_update_product_form][:description],
    #   price: params[:product_forms_update_product_form][:price],
    #   category_id: params[:product_forms_update_product_form][:category_id],
    #   stock_quantity: params[:product_forms_update_product_form][:stock_quantity]
    # )

    # if params[:thumbnail]
    #   @product.thumbnail.attach(params[:thumbnail])
    # end

    # if params[:gallery]
    #   @product.gallery.attach(params[:gallery])
    # end

    Admin::ProductServices.new(@product, params).save_variations

    if @form.update
      flash[:success] = "Product updated successfully!"
      redirect_to admin_products_path
    else
      render :edit
    end
  end
end
