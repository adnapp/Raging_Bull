class StocksController < ApplicationController
    before_action :api_client
    skip_before_action :authorized

    def index
        lists
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.create(stock_params)
        redirect_to stock_buy_path(@stock.ticker)
    end

    def show  #shows individual stocks  
            if params[:search]
                if @client.price(params[:search]) != nil #an attempt at error handling
                    @key_stats = @client.key_stats(params[:search])
                    @company = @client.company(params[:search])
                    @news = @client.news(params[:search], 3)
                    @quote = @client.quote(params[:search])
                    @ticker = params[:search]
                else
                    redirect_to stocks_path
                end
            else
                    @key_stats = @client.key_stats(params[:stockticker])
                    @company = @client.company(params[:stockticker])
                    @news = @client.news(params[:stockticker], 3)
                    @quote = @client.quote(params[:stockticker])
                    @ticker = params[:stockticker]
            end   
    end

    def new
        @stock = Stock.new
        @number = Random.rand(500)
    end

    def create
        stock = Stock.create(stock_params)
        redirect_to stock_new_path 
    end 

    def active
        @active = @client.stock_market_list(:mostactive)
    end 

    def gainers 
        @gainers = @client.stock_market_list(:gainers)
    end 

    def losers
        @losers = @client.stock_market_list(:losers)
    end 

    def volume 
        @volume = @client.stock_market_list(:iexvolume)
    end

    def percent 
        @percent = @client.stock_market_list(:iexpercent)
    end 

    def lists
        # byebug
    end 

private
    def api_client
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_28e84a02533f42b19d47d6545f0083c3',
            secret_token: 'secret_token',
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
    end

    def stock_params
        params.require(:stock).permit(:ticker)
    end  
    
end
