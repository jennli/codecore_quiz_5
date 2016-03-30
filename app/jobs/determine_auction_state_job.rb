class DetermineAuctionStateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    auction = args[0]
    max_bid_amount = auction.max_bid
    if max_bid_amount >= auction.price
      auction.reserve_met!

    elsif auction.end_date.to_date >= Date.today
      auction.publish!

    else
      byebug
      auction.reserve_not_met!
    end
  end
end
