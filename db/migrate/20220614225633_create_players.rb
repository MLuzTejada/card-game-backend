class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :phone
      t.string :cards, array: true 
      t.boolean :uno, default: false
      t.string :token
      t.timestamps
    end
  end
end
