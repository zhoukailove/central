# -*- encoding : utf-8 -*-
include ActionView::Helpers::SanitizeHelper
class Commodity < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  has_many :photos, -> { order "position" }, dependent: :destroy



end
