class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:show, :edit, :destroy, :update, :info_update]
  before_action :set_prefecture, only: [:show]

  def index
    @ladies_items = Item.set_index(category_id: 1)
    @mens_items = Item.set_index(category_id: 2)
    @kids_items = Item.set_index(category_id: 3)
    @cosme_items = Item.set_index(category_id: 7)
    @chanel_items = Item.set_index(brand_id: 1)
    @louisvuitton_items = Item.set_index(brand_id: 3)
    @supreme_items = Item.set_index(brand_id: 4)
    @nike_items = Item.set_index(brand_id: 2)
  end

  def new
    @item = Item.new
    @item.images.build
    @category = Category.new
  end

  def create
    @item = Item.new(item_params)
    @item.save!
    redirect_to root_path
  end

  def show
    @images = @item.images
  end

  def edit
  end

  def update
    if @item.update(trade_status: trade_status_update[:trade_status])
      redirect_to item_path(@item)
    else
      render :edit
    end

  end

  def info_update
      @image = Image.find_by(item_id: @item.id)
    begin
      @image.destroy
      @item.update(item_params)
    rescue
      render action: :edit and return
    end
    redirect_to root_path
  end

  def destroy
    @item.destroy if @item.user_id === current_user.id
    redirect_to root_path
  end

  def search
  end

  private

  def item_params
    params.require(:item).permit(:name, :description,:price,:condition,:shipping_fee,:days_before_shipping,:shipping_method,:trade_status,:prefecture_id,:brand_id,:category_id,:size_id,images_attributes: [:id,:name]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def trade_status_update
    params.permit(:trade_status)
  end
  def set_prefecture
    @prefecture = Prefecture.find(@item.prefecture_id)
  end
  end
