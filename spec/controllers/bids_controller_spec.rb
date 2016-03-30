require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:auction) {FactoryGirl.create(:auction,{user: user})}

  describe "#create" do
    login_user
    context "with valid attributes" do
      def valid_request
        post :create, auction_id: auction.id, bid: {amount: 100}
      end

      it "creates a record in the database" do
        count_before = Bid.count
        valid_request
        count_after = Bid.count
        expect(count_after - count_before).to eq(1)
      end

      it "redirects to the auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(auction))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      def invalid_request
        post :create, auction_id: auction.id, bid: {amount: -1}
      end

      it "doesn't create a record in the database" do
        count_before = Bid.count
        invalid_request
        count_after = Bid.count
        expect(count_after).to eq(count_before)
      end

      it "redicts to the auction show" do
        invalid_request
        expect(response).to redirect_to auction
      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end

  end
end
