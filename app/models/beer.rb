class Beer < ApplicationRecord
  belongs_to :brewery

  def self.owned_by_brewery(params)
    sorted_beers = self.where("brewery_id = #{params[:id]}")
    sorted_beers = sorted_beers.sort_by{|beer| beer.name} if params[:q] == 'alpha'
    sorted_beers = sorted_beers.where("abv > #{params[:abv]}") unless params[:abv].nil?
    sorted_beers
  end
end
