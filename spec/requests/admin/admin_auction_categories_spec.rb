require 'rails_helper'

RSpec.describe "Admin::AuctionCategories", :type => :request do
  describe "GET /admin_auction_categories" do
    it "works! (now write some real specs)" do
      get admin_auction_categories_path
      expect(response.status).to be(200)
    end
  end
end
