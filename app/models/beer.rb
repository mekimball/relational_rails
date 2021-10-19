class Beer < ApplicationRecord
  belongs_to :brewery

  def self.owned_by_brewery(params)
    sorted_beers = self.where("brewery_id = #{params[:id]}")
    sorted_beers = sorted_beers.order(:name) if params[:q] == 'alpha'
    sorted_beers = sorted_beers.where("abv > #{params[:abv]}") unless params[:abv].nil?
    sorted_beers
  end

  def self.ales
    self.where("is_an_ale = true")
  end
end
