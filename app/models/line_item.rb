class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def self.from_car_item(car_item)
    li=self.new
    li.product=car_item.product
    li.quantity=car_item.quantity
    li.total_price=car_item.price
   
    li
  end
end
