module Magento
  class OrderItem < Base
    class << self      
      def find_by_id(id)
        Magento::Order.list.each do |order|
          item = Order.find_by_increment_id(order.increment_id).order_items.select{ |i| i.id == id }
          return item.first if item and item.first
        end
      end
      
      def find_by_order_and_id(order_id, id)
        Magento::Order.find_by_id(order_id).order_items.select{ |i| i.id == id }.first
      end
    end
    
    def id
      self.item_id
    end
    
    def order
      Magento::Order.find_by_id(self.order_id)
    end
    
    def product
      Magento::Product.find_by_id_or_sku(self.product_id)
    end
  end
end