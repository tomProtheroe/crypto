class CryptocurrenciesController < ApplicationController
  before_action :set_cryptocurrency, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy show]


  # GET /cryptocurrencies or /cryptocurrencies.json
  def index
    @cryptocurrencies = Cryptocurrency.all
    require 'net/http'
    require 'json'
    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=8e364003-38f2-410d-81af-9166deca3a6f'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 = @array1[1].to_a
    @lookup_crypto = @array2[1].to_a
    @profit_loss = 0
  end

  # GET /cryptocurrencies/1 or /cryptocurrencies/1.json
  def show
    @cryptocurrencies = Cryptocurrency.all
    require 'net/http'
    require 'json'
    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=8e364003-38f2-410d-81af-9166deca3a6f'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 = @array1[1].to_a
    @show_crypto = @array2[1].to_a
  end

  # GET /cryptocurrencies/new
  def new
    @cryptocurrency = Cryptocurrency.new
  end

  # GET /cryptocurrencies/1/edit
  def edit
  end

  # POST /cryptocurrencies or /cryptocurrencies.json
  def create
    @cryptocurrency = Cryptocurrency.new(cryptocurrency_params)

    respond_to do |format|
      if @cryptocurrency.save
        format.html { redirect_to @cryptocurrency, notice: "Cryptocurrency was successfully created." }
        format.json { render :show, status: :created, location: @cryptocurrency }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cryptocurrency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptocurrencies/1 or /cryptocurrencies/1.json
  def update
    respond_to do |format|
      if @cryptocurrency.update(cryptocurrency_params)
        format.html { redirect_to @cryptocurrency, notice: "Cryptocurrency was successfully updated." }
        format.json { render :show, status: :ok, location: @cryptocurrency }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cryptocurrency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptocurrencies/1 or /cryptocurrencies/1.json
  def destroy
    @cryptocurrency.destroy
    respond_to do |format|
      format.html { redirect_to cryptocurrencies_url, notice: "Cryptocurrency was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cryptocurrency
      @cryptocurrency = Cryptocurrency.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cryptocurrency_params
      params.require(:cryptocurrency).permit(:symbol, :user_id, :cost_per, :amount)
    end

    def correct_user
      @correct = current_user.cryptocurrencies.find_by(id: params[:id])
      redirect_to cryptocurrencies_path, notice: "Not authorized to edit this entry" if @correct.nil?
    end
end
