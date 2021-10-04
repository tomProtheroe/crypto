class HomeController < ApplicationController
  def index
    #@cryptocurrencies = Cryptocurrency.all.where(user_id: current_user.id)
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=8e364003-38f2-410d-81af-9166deca3a6f'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 = @array1[1].to_a
    @lookup_coin = @array2[1].to_a
  end

  def about
    
  end

  def lookup
    
    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=8e364003-38f2-410d-81af-9166deca3a6f'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 = @array1[1].to_a
    @lookup_coin = @array2[1].to_a
   
    @symbol = params[:sym]

    if @symbol
      @symbol = @symbol.upcase
    end
    if @symbol == ""
      @symbol = "No currency entered"
    end
  end
end
