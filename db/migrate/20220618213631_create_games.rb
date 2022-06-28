class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :roomCode
      t.string :current_card, default: "3Y"
      t.timestamps
    end
  end
end
