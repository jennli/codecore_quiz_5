require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe "validations" do

    it "requires an amount" do
      b = Bid.new
      b.valid?
      expect(b.errors).to have_key(:amount)
    end
  end
end
