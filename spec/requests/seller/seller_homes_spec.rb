require 'rails_helper'

RSpec.describe "Seller::Homes", :type => :request do
  describe "GET /seller_homes" do
    it "works! (now write some real specs)" do
      get seller_homes_path
      expect(response.status).to be(200)
    end
  end
end
