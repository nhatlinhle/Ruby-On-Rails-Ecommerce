module ProductForms
  class CreateProductVariationForm
    include ActiveModel::Model

    attr_accessor :sku, :price, :stock_quantity, :description, :parent_id

    validates :sku, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :description, presence: true
    validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :parent_id, presence: true

    def create
      return false unless valid?

      product = Product.new(
        sku: sku,
        price: price,
        stock_quantity: stock_quantity,
        description: description,
        parent_id: parent_id
      )
    end
  end
end
