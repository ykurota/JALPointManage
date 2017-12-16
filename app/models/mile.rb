class Mile < ApplicationRecord
    validates :username, presence: {message:'neccesary'}
end
