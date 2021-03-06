class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  skip_before_filter :require_admin,:only=>[:find_products_with_category,:search,:show,:latest]
  skip_before_filter :require_login,:only=>[:search,:find_products_with_category,:show,:latest]
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    upload
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])&&upload
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    File.delete("#{RAILS_ROOT}/public/#{@product.image_url}"
    )
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  def find_products_with_category
    category= Category.find(params[:category_id])
    @products= category.products

    
  end

  def latest
    @products=Product.all(:conditions=>{:created_at=>(Time.now.midnight-7.day)..Time.now});
    render "find_products_with_category"

  end

  def search

    @products=Product.all(:conditions=>"name like '%#{params[:key]}%'")
#    @products=Product.find_by_solr(params[:key])

  end
  def upload
    uploaded_io = params[:product][:image_url]
    File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read) 
    end
    @product.image_url="/images/"+uploaded_io.original_filename
  end

end
