module Admin
  class AuctionCategoriesController < BaseController
    before_action :set_auction_category, only: [:show, :edit, :update, :destroy]

    # GET /admin/auction_categories
    def index
      @q = AuctionCategory.search(params[:q])
      @auction_categories = @q.result.paginate(:page => params[:page], :per_page => 100)
      #@auction_categories = AuctionCategory.all
    end

    # GET /admin/auction_categories/1
    def show
    end

    # GET /admin/auction_categories/new
    def new
      @auction_category = AuctionCategory.new
    end

    # GET /admin/auction_categories/1/edit
    def edit
    end

    # POST /admin/auction_categories
    def create
      @auction_category = AuctionCategory.new(auction_category_params)
      @auction_category.status = true
      if @auction_category.save
        redirect_to new_admin_auction_category_path,  success: "
        #{@auction_category.name}创建成功！ID--#{@auction_category.id}，级别--#{@auction_category.level},--
        父级ID--#{@auction_category.upid}
"
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /admin/auction_categories/1
    def update
      if @auction_category.update(auction_category_params)
        loop(@auction_category.id,@auction_category.status)
        redirect_to admin_auction_categories_path, success: '变更完成'
      else
        render action: 'edit'
      end
    end

    # DELETE /admin/auction_categories/1
    def destroy
      @auction_category.status = false
      @auction_category.save
      loop(@auction_category.id,@auction_category.status)
      #redirect_to admin_auction_categories_url, success: '删除成功'
    end



    def loop(id,status)
      auction_categories = AuctionCategory.where(upid: id)
      if auction_categories.present?

        auction_categories.each do |auction_category|
          auction_category.status = status
          auction_category.save
          loop(auction_category.id,status)
        end

      end
    end

    #def loop_destroy(id,status)
    #  auction_categories = AuctionCategory.where(upid: id)
    #  if auction_categories.present?
    #    auction_categories.each do |auction_category|
    #      auction_category.status = status
    #      auction_category.save
    #      loop_destroy(auction_category.id,status)
    #    end
    #  end
    #end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction_category
      @auction_category = AuctionCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def auction_category_params
      params.require(:auction_category).permit(:name, :level, :upid, :status)
    end
  end
end