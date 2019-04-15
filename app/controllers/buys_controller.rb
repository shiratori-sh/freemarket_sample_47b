class BuysController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :create]
  before_action :set_buys, only: [ :index, :create]

  def index
  end

  def create
    if @item.trade_status == 1
      create_purchase_history(@item)
      # 本家の購入確認後のページの確認ができないため仮置きでrootページを表示
      redirect_to root_path
    else
      # 本家の購入確認後のページの確認ができないため仮置きで商品購入ページを再表示
      redirect_to item_buys_path
    end
  end

  def show
  end

private

  def set_buys
    @item = Item.find(params[:item_id])
    @images = @item.images
  end

  def create_purchase_history(item)
    partner = TradingPartner.where(seller_id: item.user_id, buyer_id: current_user.id).first_or_create
    Order.create(item_id: item.id, trading_partner_id: partner.id, status: 3)
    item.update(trade_status: 3)
  end

end
