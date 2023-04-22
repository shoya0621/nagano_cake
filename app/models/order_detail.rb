class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum production_status: { impossible: 1, wait: 2, making: 3, complete: 4 }
  
end
