class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products,:through=>:line_items
  PAYMENT_TYPES=[
    ["Check","check"],
    ["Credit card","cc"],
    ["Purchase order","po"]
  ]

  validates_format_of  :email,:with =>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,:message=>' email is not correct'
  validates_presence_of :name,:address,:email,:pay_type
def add_line_item_from_car(car)
  car.items.each do |item|
    li=LineItem.from_car_item(item)
    line_items<<li
  end

end

end
