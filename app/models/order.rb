class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum payment_method: { credit_card: 1, transfer: 2 }
  enum status: { waiting: 1, comfirm: 2, making: 3, prepare: 4, deliver: 5}
end
