# -*- encoding : utf-8 -*-
class Seller::BaseController < ApplicationController
  layout 'seller'
  before_action :authorize_seller

  private

  def authorize_seller
    redirect_to root_path, warning: '仅允许卖家进行操作！' unless current_user && current_user.seller
  end
end
