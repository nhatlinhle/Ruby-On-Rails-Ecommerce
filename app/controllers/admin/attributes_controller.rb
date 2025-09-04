class Admin::AttributesController < Admin::BaseController
  include AttributeHelper

  layout "admin"

  def index
    @attributes = ProductAttribute.all
    @attributes = @attributes.order(id: :asc)
    @attributes = @attributes.page(params[:page]).per(20)

    render "admin/attributes/index"
  end

  def new
    @attribute = ProductAttribute.new
  end

  def create
    @attribute = ProductAttribute.new(attribute_params)

    if @attribute.save
      redirect_to admin_attributes_path, notice: "Attribute created successfully."
    else
      render :new
    end
  end

  def bulk_create
    return render json: { status: "error", message: "No attributes provided." }, status: :unprocessable_entity if params[:attributes].blank?

    product = Product.find(params[:product_id])
    expected_pavs = []
    created_attributes = []

    params[:attributes].each do |_index, attr_params|
      if existing_attribute?(attr_params)
        expected_pavs.concat build_expected_existing_pavs(attr_params, product.id)
      else
        result = create_attribute_and_values(attr_params)
        expected_pavs.concat result[:pavs].map { |pav| pav.merge(product_id: product.id) }
        created_attributes << result[:response]
      end
    end

    sync_product_attribute_values(product.id, expected_pavs)

    render json: { status: "success", created: created_attributes }

  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "error", message: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
  rescue => e
    render json: { status: "error", message: e.message }, status: :unprocessable_entity
  end

  def get_attributes_by_product_id
    product = Product.find(params[:product_id])

    grouped = product.product_attribute_values
      .includes(:attribute_record, :attribute_value)
      .group_by(&:attribute_record)

    attributes = grouped.map do |attribute, pavs|
      {
        id: attribute.id,
        name: attribute.name,
        values: pavs.map do |pav|
          {
            id: pav.attribute_value.id,
            name: pav.attribute_value.name
          }
        end
      }
    end

    render json: { status: "success", attributes: attributes }
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Product not found." }, status: :not_found
  rescue => e
    render json: { status: "error", message: e.message }, status: :unprocessable_entity
  end

  private

  def attribute_params
    params.require(:product_attribute).permit(:name, :options)
  end
end
