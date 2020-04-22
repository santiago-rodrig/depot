class LineitemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: :create
  before_action :set_lineitem, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_item

  # GET /lineitems
  # GET /lineitems.json
  def index
    @lineitems = Lineitem.all
  end

  # GET /lineitems/1
  # GET /lineitems/1.json
  def show
  end

  # GET /lineitems/new
  def new
    @lineitem = Lineitem.new
  end

  # GET /lineitems/1/edit
  def edit
  end

  # POST /lineitems
  # POST /lineitems.json
  def create
    session.delete(:counter)
    product = Product.find(params[:product_id])
    @lineitem = @cart.add_product(product)

    respond_to do |format|
      if @lineitem.save
        format.html { redirect_to @lineitem.cart }
        format.json { render :show, status: :created, location: @lineitem }
      else
        format.html { render :new }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineitems/1
  # PATCH/PUT /lineitems/1.json
  def update
    respond_to do |format|
      if @lineitem.update(lineitem_params)
        format.html { redirect_to @lineitem, notice: 'Lineitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @lineitem }
      else
        format.html { render :edit }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineitems/1
  # DELETE /lineitems/1.json
  def destroy
    cart = @lineitem.cart
    if @lineitem.quantity == 1
      @lineitem.destroy
    else
      @lineitem.quantity -= 1
      @lineitem.save
    end
    respond_to do |format|
      format.html { redirect_to cart, notice: 'Lineitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lineitem
    @lineitem = Lineitem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lineitem_params
    params.require(:lineitem).permit(:product_id)
  end

  def invalid_item
    logger.error "Attemp to access invalid item #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid line item'
  end
end
