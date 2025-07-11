class AttributeValue < ApplicationRecord
  belongs_to :attribute

  has_many :product_attribute_values
  has_many :products, through: :product_attribute_values
end
