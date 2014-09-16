# -*- encoding : utf-8 -*-
class Commodity
  module CommodityGroup
    extend ActiveSupport::Concern
    

    module ClassMethods
      def group_destroy(ids)
        transaction do
          destroy_all(id: ids)
        end
      end
    end
  end
end
