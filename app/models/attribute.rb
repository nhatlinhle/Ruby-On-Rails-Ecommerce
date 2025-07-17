class Attribute < ApplicationRecord
  has_many :attribute_values, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
