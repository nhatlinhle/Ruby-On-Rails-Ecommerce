class ProductAttributeValue < ApplicationRecord
  belongs_to :product
  belongs_to :attribute
  belongs_to :attribute_value
end
