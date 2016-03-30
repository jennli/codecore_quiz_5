require 'rails_helper'
require 'devise'
RSpec.describe AuctionsController, type: :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:auction) {FactoryGirl.create(:auction,{user: user})}


  describe "#new" do
    login_user
    it "renders the new template" do
      # This mimics sending a get request to the new action
      get :new
      # response is an object that is given to us by RSpec that will help test
      # things like redirect / render
      # render_template is a an RSpec (rspec-rails) matcher that help us check
      # if the controller renders the template with the given name.
      expect(response).to render_template(:new)
    end

    it "instantiates a new auction object and sets it to @auction" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    login_user
    context "with valid attributes" do
      def valid_request
        post :create, auction: {title: "some valid title",
          details: "some valid details",
          price: 4000,
          end_date:  60.days.from_now
        }
      end
      it "creates a record in the database" do
        count_before = Auction.count
        valid_request
        count_after = Auction.count
        expect(count_after - count_before).to eq(1)
      end

      it "redirects to the auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end

    end
    context "with invalid attributes" do

      def invalid_request
        post :create, auction: {title: "some title"
        }
      end

      it "doesn't create a record in the database" do
        count_before = Auction.count
        invalid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template :new
      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
