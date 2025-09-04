module AttributeHelper
  def existing_attribute?(attr_params)
    attr_params["is"].present? && attr_params["is"] == "existing"
  end

  def build_expected_existing_pavs(attr_params, product_id)
    attribute_id = attr_params["attribute_id"].to_i
    attr_params["options"].map do |value_id|
      {
        product_id: product_id,
        attribute_id: attribute_id,
        attribute_value_id: value_id.to_i
      }
    end
  end

  def create_attribute_and_values(attr_params)
    attribute = Attribute.new(
      name: attr_params[:name],
      slug: attr_params[:name].parameterize
    )
    attribute.save!

    pavs = []
    values = attr_params[:options].map do |value_name|
      value = attribute.attribute_values.create!(
        name: value_name,
        slug: value_name.parameterize
      )
      pavs << {
        attribute_id: attribute.id,
        attribute_value_id: value.id
      }
      value
    end

    {
      pavs: pavs,
      response: {
        id: attribute.id,
        name: attribute.name,
        values: values.map { |v| { id: v.id, name: v.name } }
      }
    }
  end

  def sync_product_attribute_values(product_id, expected_pavs)
    existing = ProductAttributeValue.where(product_id: product_id)

    to_delete = existing.reject do |pav|
      expected_pavs.any? do |e|
        e[:attribute_id] == pav.attribute_id && e[:attribute_value_id] == pav.attribute_value_id
      end
    end

    ProductAttributeValue.where(id: to_delete.map(&:id)).delete_all if to_delete.any?

    expected_pavs.each do |e|
      unless existing.any? { |pav| pav.attribute_id == e[:attribute_id] && pav.attribute_value_id == e[:attribute_value_id] }
        ProductAttributeValue.create!(e)
      end
    end
  end
end
