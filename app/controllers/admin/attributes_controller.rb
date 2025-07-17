class Admin::AttributesController < Admin::BaseController
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
  if params[:attributes].blank?
    return render json: { status: "error", message: "No attributes provided." }, status: :unprocessable_entity
  end

  created = []
  params[:attributes].each do |_index, attr_params|
    if attr_params["is"].present? && attr_params["is"] == "existing"
      attribute_id = attr_params["attribute_id"]
      product_id = params[:product_id]

      attr_params["options"].each do |attribute_value_id|
        ProductAttributeValue.create!(
          product_id: product_id,
          attribute_id: attribute_id,
          attribute_value_id: attribute_value_id
        )
      end
      next
    end
    attribute = Attribute.new(
      name: attr_params[:name],
      slug: attr_params[:name].parameterize
    )

    unless attribute.valid?
      raise ActiveRecord::RecordInvalid.new(attribute)
    end

    attribute.save!

    attr_params[:options].each do |value|
      attr_value = attribute.attribute_values.new(
        name: value,
        slug: value.parameterize
      )

      unless attr_value.valid?
        raise ActiveRecord::RecordInvalid.new(attr_value)
      end

      attr_value.save!
    end

    created << {
      id: attribute.id,
      name: attribute.name,
      values: attribute.attribute_values.pluck(:name)
    }
  end

  render json: { status: "success", created: created }

  rescue ActiveRecord::RecordInvalid => e
    render json: { status: "error", message: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity

  rescue => e
    render json: { status: "error", message: e.message }, status: :unprocessable_entity
  end

  private

  def attribute_params
    params.require(:product_attribute).permit(:name, :options)
  end
end
