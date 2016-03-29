class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction

  def create
    if current_user != @auction.user
      @bid = @auction.bids.new bid_params
      @bid.user = current_user
      if @bid.save
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
