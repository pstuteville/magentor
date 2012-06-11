module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1061   Can not make operation because of customer shipping address is not set
  # 1062   Shipping method is not available
  # 1063   Can not set shipping method.
  # 1064   Can not receive list of shipping methods.
  class CartShipping < Base
    class << self      

      # cart_shipping.method
      # Set a shipping method for shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # string shippingMethod - shipping method code
      # mixed (int | string) storeView - Store view Id or code (optional)
      def method(*args)
        commit('method', *args)
      end

      # cart_shipping.list
      # Get list of available shipping methods for shopping cart
#       
      # Return: array of CartShippingMethodEntity - an array with list of available shipping methods
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
    end
  end
end