class Product < ApplicationRecord
  # Self-referencing associations
  has_many :variations, class_name: "Product", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Product", optional: true

  # Attributes
  has_many :product_attribute_values
  has_many :attribute_values, through: :product_attribute_values
  has_many :product_attributes, through: :product_attribute_values, source: :attribute_record

  belongs_to :category
  has_many :product_metas, dependent: :destroy

  # Active Storage attachments
  has_one_attached :thumbnail
  has_many_attached :gallery
end
