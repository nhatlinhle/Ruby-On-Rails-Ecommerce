class ProductAttributeValue < ApplicationRecord
  belongs_to :product
  belongs_to :attribute_record, class_name: "Attribute", foreign_key: "attribute_id"
  belongs_to :attribute_value
end
