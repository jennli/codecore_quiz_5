class AuctionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :show]
  before_action :find_auction, only:[:show]

  def index
    @auctions = Auction.where("aasm_state != ?" , "draft")
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, notice:"auction_created"
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def show
    if @auction.aasm_state == "draft" && @auction.user != current_user
      redirect_to root_path, alert:"you don't have permission to view this auction"
    else
      @bids = @auction.bids.order("created_at DESC")
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :details, :price, :end_date)
  end

  def find_auction
    @auction = Auction.find(params[:id]).decorate
  end

end
