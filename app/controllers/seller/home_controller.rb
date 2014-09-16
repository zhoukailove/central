# -*- encoding : utf-8 -*-
module Seller
class HomeController < BaseController
  before_action :set_seller_home, only: [:show, :edit, :update, :destroy]
  #before_filter :configure_charsets
  # GET /seller/home
  def index
    @users_count                = User.count
    @groups_count               = Group.count
    @messages_count             = Message.count
    @unread_nitofications_count = Notification.unread.count
    @tags_count                 = Tag.count
  end


    def configure_charsets
      @headers["Content-Type"]="text/html;charset=utf-8"
    end

    def uploadFile(file)
      if !file.original_filename.empty?
        #生成一个随机的文件名
        @filename=getFileName(file.original_filename)
        #向dir目录写入文件
        File.open("#{RAILS_ROOT}/public/emag/upload/#{@filename}", "wb") do |f|
          f.write(file.read)
        end
        #返回文件名称，保存到数据库中
        return @filename
      end
    end

    def getFileName(filename)
      if !filename.nil?
        require 'uuidtools'
        filename.sub(/.*./,UUID.random_create.to_s+'.')
      end
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

  def create
    if request.get?
      @book=Book.new
    else
      @book=Book.new(params[:book])
      @book.bgImage=uploadFile(params[:book]['bgImage'])
      if @book.save
        redirect_to_index
      end
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