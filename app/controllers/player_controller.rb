class PlayerController < ApplicationController
    before_action :set_player_by_name_password, only:[:login]
    before_action :set_player_by_id, only:[:logout, :update, :setUno, :update_password, :getGame]
    before_action :check_token, only:[:logout, :setUno, :update, :update_password, :getGame]
    before_action :set_game_by_player_id, only:[:getGame]

    # POST player/register
    def register
        @player = Player.new(player_params)
        if @player.save
            render json: @player, status: :created
        else
            render json: @player.errors, status: :unprocessable_entity
        end
    end

    # POST player/login
    def login
        if !@player.nil?
            cookies[:player_id] = @player.id
            render json: @player, status: 200
        else
            render json: { message: "Jugador no encontrado" }, status: 404
        end
    end

    # GET player/logout/3
    def logout
        cookies[:player_id] = nil
        render json: { message: "Cerro sesion satisfactoriamente" }, status: 200
    end

    # GET player/current
    def show
        @player = Player.find_by(id: cookies[:player_id])
        render json: @player
    end

    # PUT player/:id
    def update
        if @player.update(player_long_params)
          render json: @player
        else
          render json: @player.errors, status: :unprocessable_entity
        end
    end

    # PUT player/:id/password
    def update_password
        if @player.update(player_password_params)
          render json: @player
        else
          render json: @player.errors, status: :unprocessable_entity
        end
    end

    # GET player/:id/getGame
    def getGame
        if @game.nil?
            render json: { message: "Partida no encontrada" }, status: 404
        end
        render json: {game: @game, players: @game.players}, status: 200
    end

    # POST player/:id/setUno
    def setUno
        @player.uno = true
        if @player.save
            render json: { message: "El jugador grito UNO" }, status: 200
        else
            render json: { errors: @player.errors }, status: :unprocessable_entity
        end
    end

    private
        def player_params
            params.require(:player).permit(:username, :password)
        end

        def player_long_params
            params.require(:player).permit(:username, :email, :phone)
        end

        def player_password_params
            params.require(:player).permit(:password)
        end

        def set_player_by_name_password
            @player = Player.find_by(username: params[:username], password: params[:password])
        end

        def set_player_by_id
            @player = Player.find(params[:id]) 
        end

        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Jugador no autorizado" }, status: 401
            false
        end

        private
        def set_game_by_player_id
            @game = Player.find(params[:id]).games.last
        end
end
