require 'rails_helper'

RSpec.describe FoodGroup do
  it {should have_many :foods}
end
