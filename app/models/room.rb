class Room < ApplicationRecord
  has_secure_token :code
  has_many :users
end
