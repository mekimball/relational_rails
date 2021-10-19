class FoodGroup < ApplicationRecord
  has_many :foods, dependent: :destroy
end
