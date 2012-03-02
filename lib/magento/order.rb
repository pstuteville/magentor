module Magento
  class Order < Base
    # http://www.magentocommerce.com/wiki/doc/webservices-api/api/sales_order
    # 100  Requested order not exists.
    # 101  Invalid filters given. Details in error message.
    # 102  Invalid data given. Details in error message.
    # 103  Order status not changed. Details in error message.
    class << self
      # sales_order.list
      # Retrieve list of orders by filters
      #
      # Return: array
      #
      # Arguments:
      #
      # array filters - filters for order list (optional)
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end

      # sales_order.info
      # Retrieve order information
      #
      # Return: array
      #
      # Arguments:
      #
      # string orderIncrementId - order increment id
      def info(*args)
        new(commit("info", *args))
      end

      # sales_order.addComment
      # Add comment to order
      #
      # Return: boolean
      #
      # Arguments:
      #
      # string orderIncrementId - order increment id
      # string status - order status
      # string comment - order comment (optional)
      # boolean notify - notification flag (optional)
      def add_comment(*args)
        commit('addComment', *args)
      end

      # sales_order.hold
      # Hold order
      #
      # Return: boolean
      #
      # Arguments:
      #
      # string orderIncrementId - order increment id
      def hold(*args)
        commit('hold', *args)
      end

      # sales_order.unhold
      # Unhold order
      #
      # Return: boolean
      #
      # Arguments:
      #
      # mixed orderIncrementId - order increment id
      def unhold(*args)
        commit('unhold', *args)
      end

      # sales_order.cancel
      # Cancel order
      #
      # Return: boolean
      #
      # Arguments:
      #
      # mixed orderIncrementId - order increment id
      def cancel(*args)
        commit('cancel', *args)
      end

      def find_by_id(id)
        find(:first, {:order_id => id})
      end

      def find_by_increment_id(id)
        info(id)
      end

      def find(find_type, options = {})
        filters = {}
        options.each_pair { |k, v| filters[k] = {:eq => v} }
        results = list(filters)

        raise Magento::ApiError, "100 -> Requested order not exists." if results.blank?

        if find_type == :first
          info(results.first.increment_id)
        else
          results.collect do |o|
            info(o.increment_id)
          end
        end
      end
    end

    def order_items
      if (!self.attributes.has_key? 'items')
        self.attributes.merge! Magento::Order.info(self.increment_id).attributes
      end

      self.items.collect do |item|
        Magento::OrderItem.new(item)
      end
    end

    def payment_info
      if (!self.attributes.has_key? 'payment')
        self.attributes.merge! Magento::Order.info(self.increment_id).attributes
      end

      self.payment
    end

    def shipping_address
      Magento::CustomerAddress.new(@attributes["shipping_address"])
    end

    def billing_address
      Magento::CustomerAddress.new(@attributes["billing_address"])
    end
  end
end
