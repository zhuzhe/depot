class StoreController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_admin
  
  def index

  end
  
 
  
  def add_to_car
    @car=find_car
    product=Product.find(params[:id])
    @car.add_product(product)
  end

  def empty_car
    session[:car]=nil
    redirect_to_index("YOU CART IS EMPTY")
  end

  def remove_from_car
    @car=session[:car]
    @car.remove_product(Product.find(params[:id]) )
    render "add_to_car"
  end

  def edit_quantity
    @car=session[:car]
    current_item=@car.items.find{|item|item.product==Product.find(params[:car_item][:product_id])}
    
    current_item.quantity=params[:car_item][:quantity].to_i
       
       
     
    render "add_to_car"
  end

  
end
