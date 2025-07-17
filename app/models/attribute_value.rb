class AttributeValue < ApplicationRecord
  belongs_to :product_attribute, class_name: "Attribute", foreign_key: "attribute_id"

  has_many :product_attribute_values
  has_many :products, through: :product_attribute_values

  validates :name, presence: true
  validates :slug, presence: true
end
