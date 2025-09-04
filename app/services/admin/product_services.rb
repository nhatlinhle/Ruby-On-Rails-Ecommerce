module Admin
  class ProductServices
    def initialize(record, attribute)
      @record = record
      @attribute = attribute
    end

    def save_variations
      variations = @attribute.dig('product', 'variations')
      return if variations.blank?

      product_variable_id = @attribute[:id]

      variations.each do |_, variation|
        next if variation.blank? || _ == "NEW_RECORD"

        if variation["id"].present?
          # Update product variation
          product_id = variation["id"]
          product = Product.find(product_id)
          @data = ::ProductForms::UpdateProductForm.new(
            product: product,
            sku: variation["sku"],
            name: product.name,
            description: variation["description"],
            price: variation["price"],
            category_id: product.category_id,
            stock_quantity: variation["stock_quantity"]
          )
        else
          # Create product variation
          
        end

        puts variation.inspect
      end
    end
  end
end
