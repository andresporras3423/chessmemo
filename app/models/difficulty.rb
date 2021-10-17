class Difficulty < ApplicationRecord
    has_many :configs
    has_many :player, :through => :configs
end
