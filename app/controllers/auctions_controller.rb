class AuctionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  before_action :find_auction, only:[:show]

  def index
    @auctions = Auction.order("created_at ASC").published
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.create auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, notice:"auction_created"
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def show
    @bids = @auction.bids.order("created_at DESC")
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :details, :price, :end_date)
  end

  def find_auction
    @auction = Auction.find(params[:id]).decorate
  end

end
