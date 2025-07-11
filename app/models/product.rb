class Product < ApplicationRecord
  has_many :variations, class_name: "Product", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Product", optional: true

  has_many :product_attribute_values
  has_many :attribute_values, through: :product_attribute_values
  has_and_belongs_to_many :categories
  has_many :product_metas, dependent: :destroy
end
