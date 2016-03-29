class MyAuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @auctions = current_user.auctions
  end

end
