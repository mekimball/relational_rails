class Brewery < ApplicationRecord
  has_many :foods, dependent: :destroy
end
