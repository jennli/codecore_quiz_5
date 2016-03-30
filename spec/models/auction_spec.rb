require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe "validations" do

    it "doesn't allow creating an auction with no title" do
      a = Auction.new
      a_valid = a.valid?
      expect(a_valid).to eq(false)
    end

    it "requires a price" do
      a = Auction.new
      a.valid?
      expect(a.errors).to have_key(:price)
    end

    it "requires an end_date" do
      a = Auction.new
      a.valid?
      expect(a.errors).to have_key(:end_date)

    end

  end
end
