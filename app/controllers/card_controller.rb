class CardController < ApplicationController
    before_action :get_player_by_id, only:[:getCard, :getPlayerDeck]
    before_action :check_token

    CARDS = [
        '0R', '1R', '1R', '2R', '2R', '3R', '3R', '4R', '4R', '5R', '5R', '6R', '6R', '7R', '7R', '8R', '8R', '9R', '9R', 'skipR', 'skipR', '_R', '_R', 'D2R', 'D2R',
        '0G', '1G', '1G', '2G', '2G', '3G', '3G', '4G', '4G', '5G', '5G', '6G', '6G', '7G', '7G', '8G', '8G', '9G', '9G', 'skipG', 'skipG', '_G', '_G', 'D2G', 'D2G',
        '0B', '1B', '1B', '2B', '2B', '3B', '3B', '4B', '4B', '5B', '5B', '6B', '6B', '7B', '7B', '8B', '8B', '9B', '9B', 'skipB', 'skipB', '_B', '_B', 'D2B', 'D2B',
        '0Y', '1Y', '1Y', '2Y', '2Y', '3Y', '3Y', '4Y', '4Y', '5Y', '5Y', '6Y', '6Y', '7Y', '7Y', '8Y', '8Y', '9Y', '9Y', 'skipY', 'skipY', '_Y', '_Y', 'D2Y', 'D2Y',
        'W', 'W', 'W', 'W', 'D4W', 'D4W', 'D4W', 'D4W'
    ]

    # GET player/:id/getCard
    def getCard
        card = CARDS.sample
        @player.cards << card
        if @player.save
            render status: 200, json: { message: "Saco una carta satisfactoriamente", player: @player }
        else 
            render status: 500, json: { message: "Ocurrio un error" , player: @player.errors }
        end
    end

    # GET player/:id/getDeck
    def getPlayerDeck
        playerCards = CARDS.sample(7)
        @player.cards = playerCards
        if @player.save
            render status: 200, json: { message: "Repartio las cartas satisfactoriamente", player: @player }
        else 
            render status: 500, json: { message: "Ocurrio un error" , player: @player.errors }
        end
    end

    private
        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Jugador no autorizado" }, status: 401
            false
        end

        def get_player_by_id
            @player = Player.find(params[:id])
        end
end
