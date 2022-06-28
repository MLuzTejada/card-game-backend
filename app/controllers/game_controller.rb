class GameController < ApplicationController
    before_action :get_player_by_id, only:[:create, :move, :join]
    before_action :check_token

    # POST /game
    def create
        @game = Game.find_or_initialize_by(roomCode: params[:roomCode])
        @game.players << @player
        if @game.persisted?
            render status: 200, json: { message: "Se unio a la partida exitosamente", game: @game, players: @game.players }
        elsif @game.save
            render status: 200, json: { message: "Se creo a la partida exitosamente", game: @game }
        else
            render status: 500, json: { message: "Hubo un error creando la partida", error: @game.errors }
        end
    end

    # POST /move
    def move
        @game = Game.find_by(roomCode: params[:roomCode])
        current_number, current_color = check_color_and_number(@game.current_card)
        card_number, card_color = check_color_and_number(params[:card])
        if (current_color != "W" && card_color != "W" )
            if (current_color != card_color && current_number != card_number)
                render status: 500, json: { message: "Movimiento invalido" } and return
            end
        end
        @game.current_card = params[:card]
        if !@game.save
            render status: 500, json: { message: "Ocurrio un error" , game: @game.errors } and return
        end
        @player.cards.delete(params[:card])
        if !@player.save
            render status: 500, json: { message: "Ocurrio un error" , game: @player.errors } and return
        end
        render status: 200, json: { message: "Movimiento realizado con exito", game: @game, player: @player }
    end

    def check_color_and_number(card)
        if card.length == 2 
            color = card[1]
            number = card[0]
        elsif card.length == 3
            color = card[2]
            number = card[0..1]
        elsif card.length == 5
            color = card[4]
            number = card[0..3]
        else
            color = "W"
        end
        return number, color
    end

    private
        def get_player_by_id
            @player = Player.find_by(id: params[:id])
        end

        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Jugador no autorizado" }, status: 401
            false
        end

end
