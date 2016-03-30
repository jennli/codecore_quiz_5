class Auctions::PublishAuction
  include Virtus.model

  attribute :auction, Auction

  def call
    if auction.publish!
      DetermineAuctionStateJob.set(wait_until: auction.end_date).perform_now(auction)
      true
    else
      false
    end
  end

end
