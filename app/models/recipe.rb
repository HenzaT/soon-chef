class Recipe < ApplicationRecord
  validates :name, :ingredients, :method, presence: true
  validates :name, length: { minimum: 2 }
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: [0, 1, 2, 3, 4, 5] }
end
