class Player < ApplicationRecord
    validates :username, presence: true
    validates :password, presence: true, format: { with: /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/, message: "La contraseña debe cumplir con el formato" }
    before_create :set_token

    has_and_belongs_to_many :games
    has_one_attached :image

    serialize :cards, Array

    def set_token
        self.token = SecureRandom.uuid
    end
end
