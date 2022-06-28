class Game < ApplicationRecord
    validates :roomCode, uniqueness: true

    before_create :set_roomCode

    has_and_belongs_to_many :players

    def set_roomCode
        self.roomCode = SecureRandom.hex(10)
    end
end
