module ProductForms
  class UpdateProductForm
    include ActiveModel::Model

    attr_accessor :product, :sku, :name, :description, :price, :stock_quantity, :category_id

    validates :sku, presence: true
    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :category_id, presence: true

    def update
      return false unless valid?

      product.name = name
      product.description = description
      product.price = price
      product.category_id = category_id
      product.save
    end

    private

    def category_must_exist
      return if category_id.blank?
      unless Category.exists?(category_id)
        errors.add(:category_id, "must refer to an existing category")
      end
    end
  end
end
