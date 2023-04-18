class Item < ApplicationRecord
   has_one_attached :image
   belongs_to :genre
   has_many :cart_items
end
