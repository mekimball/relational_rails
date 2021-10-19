require 'rails_helper'

RSpec.describe Brewery do
  it {should have_many :beers}
end