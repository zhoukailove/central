# -*- encoding : utf-8 -*-
include ActionView::Helpers::SanitizeHelper
class Photo < ActiveRecord::Base
  belongs_to :commodity, :counter_cache => true

  PHOTO_MIN_LIMIT = 5 #至少上传5张照片
  PHOTO_MAX_LIMIT = 30

  mount_uploader :photo, PhotoUploader

  #validates :photo,
  #          :presence => true,
  #          :file_size => {
  #              :maximum => 4.megabytes.to_i
  #          }

  default_scope :order=> "position asc"
end
