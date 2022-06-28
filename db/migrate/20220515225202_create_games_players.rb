class CreateGamesPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :games_players do |t|
      t.belongs_to :player
      t.belongs_to :game
      t.timestamps
    end
  end
end
