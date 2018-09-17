class Server < ApplicationRecord

    has_many :containers
    has_many :image_dockers
    
end
