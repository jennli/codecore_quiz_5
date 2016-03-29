class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, presence:true
  validates :amount, numericality: { greater_than: :auction_max_price}

  def auction_max_price
    auction.max_bid
  end

end
