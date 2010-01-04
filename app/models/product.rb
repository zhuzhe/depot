class Product < ActiveRecord::Base
#  acts_as_solr :fields=>[:name,:description]
  validates_presence_of :name,:description,:image_url
  validates_numericality_of :price
  validates_numericality_of :quantity,:only_integer=>true,:greater_than_or_equal_to=>0
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :name
  validates_format_of :image_url,
    :with =>%r{\.(gif|jpg|png)$},
    :message=>"must be url for (gif|jpg|png)"
  belongs_to :category
  has_many :line_items
  has_many :comments
  has_many :orders,:through=>:line_items
  protected
  def price_must_be_at_least_a_cent
    errors.add(:price, "should be at least 0.01") if price.nil?||price<0.01
  end

  def find_products_on_sale
    all(:conditions=>{:onsale=>true},:order => "created_on DESC")
  end

  def self.decrease_products(car)
    car.items.each do |item|
      product=item.product
     
      product.quantity=item.product.quantity-item.quantity
      
      raise  "Failed to Order"  unless product.save
 
    end

  end
end
