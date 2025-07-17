class ProductMeta < ApplicationRecord
  self.table_name = "product_metas"
  belongs_to :product

  validates :key, presence: true
end
