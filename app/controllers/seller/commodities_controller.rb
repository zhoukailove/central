# -*- encoding : utf-8 -*-
module Seller
  class CommoditiesController < BaseController
    before_action :set_commodity, only: [:show, :edit, :update, :destroy]

    # GET /commodities
    def index
      @q = Commodity.search(params[:q])
      @commodities = @q.result.paginate(:page => params[:page], :per_page => per_page_count)
    end

    # GET /commodities/1
    def show
    end

    # GET /commodities/new
    def new
      @commodity = Commodity.new
    end

    # GET /commodities/1/edit
    def edit
      if params[:c_f] == 'new'
        @right_id = 'mainHouse'
      end

      unless (@commodity.user_id == current_user.id || current_user.admin == true)
        flash[:notice] = '对不起，您无权修改该商品信息'
        redirect_to seller_home_path
      end
      @tab = params[:tab]
      @photos = @commodity.photos.order('created_at desc') if @tab == 'photo'
    end

    # POST /commodities
    def create
      @commodity = Commodity.new(commodity_params)
      logger.info Commodity.column_names
      logger.info "#{commodity_params}"
      @commodity.user_id = current_user.id
      @commodity.status = true
      file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @commodity.photos = file
      #respond_to do |from|
      if @screenshot.save
        #render json: { success: true, src: @commodity.to_json }
        redirect_to "/seller/commodities/#{@commodity.id}/edit/photo?c_f=new"
      else
        #render json: @commodity.errors.to_json
        render action: 'new'
      end

    end

    def phone
      #if request.post?
        #current_user.order_phone = params[:order_phone]
        #current_user.save
        redirect_to :action => :new
      #else
      #  if current_user.order_phone.present?
      #    redirect_to :action => :new
      #  end
      #end
    end

    # PATCH/PUT /commodities/1
    def update
      if @commodity.update(commodity_params)
        redirect_to @commodity, notice: 'Commodity was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /commodities/1
    def destroy
      @commodity.destroy
      redirect_to commodities_url, notice: 'Commodity was successfully destroyed.'
    end

    def group_destroy
      @ids = params[:submit_ids].split(',')
      Commodity.group_destroy(@ids)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity
      @commodity = Commodity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def commodity_params
      params.require(:commodity).permit(:title, :user_id, :status, :commodity_number, :orders_count, :comments_count)
    end
  end
end
