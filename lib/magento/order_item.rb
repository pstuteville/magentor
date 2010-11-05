module Magento
  class OrderItem < Base
    class << self      
      def id
        @attributes["item_id"]
      end
      
      def find_by_id(order_id, id)
        Order.find_by_id(order_id).order_items.select{ |i| i.id == id }
      end
    end
  end
end