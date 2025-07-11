class ProductMeta < ApplicationRecord
  belongs_to :product

  validates :key, presence: true
end
