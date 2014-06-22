module Seller
class HomeController < BaseController
  before_action :set_seller_home, only: [:show, :edit, :update, :destroy]

  # GET /seller/home
  def index
    @users_count                = User.count
    @groups_count               = Group.count
    @messages_count             = Message.count
    @unread_nitofications_count = Notification.unread.count
    @tags_count                 = Tag.count
  end

  # GET /seller/home/1
  def show
  end

  # GET /seller/home/new
  def new
    @seller_home = Seller::Home.new
  end

  # GET /seller/home/1/edit
  def edit
  end

  # POST /seller/home
  def create
    @seller_home = Seller::Home.new(seller_home_params)

    if @seller_home.save
      redirect_to @seller_home, notice: 'Home was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /seller/home/1
  def update
    if @seller_home.update(seller_home_params)
      redirect_to @seller_home, notice: 'Home was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /seller/home/1
  def destroy
    @seller_home.destroy
    redirect_to seller_homes_url, notice: 'Home was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller_home
      @seller_home = Seller::Home.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def seller_home_params
      params[:seller_home]
    end
end
end