class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction, only:[:create]

  def index
    @bids = Bid.all
  end

  def create
    if current_user != @auction.user
      @bid = @auction.bids.new bid_params
      @bid.user = current_user
      if @bid.save
        DetermineAuctionStateJob.set(wait_until: @auction.end_date).perform_now(Auction.find(@auction.id))
        redirect_to @auction, notice:"bid created"
      else
        redirect_to @auction, alert: "#{@bid.errors.full_messages.join(",")}"
      end

    else
      redirect_to @auction, alert: "cant bid if you own this auction!"
    end

  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end

  def find_auction
    @auction = Auction.find(params[:auction_id]).decorate
  end


end
