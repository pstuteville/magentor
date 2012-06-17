module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1071   Payment method data is empty.
  # 1072   Customer’s billing address is not set. Required for payment method data.
  # 1073   Customer’s shipping address is not set. Required for payment method data.
  # 1074   Payment method is not allowed
  # 1075   Payment method is not set.
  class CartPayment < Base
    class << self      

      # cart_payment.method
      # Set a payment method for shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # CartPaymentMethodEntity paymentData - an associative array with payment method information
      # mixed (int | string) storeView - Store view Id or code (optional)
      def method(*args)
        commit('method', *args)
      end

      # cart_payment.list
      # Get list of available payment methods for shopping cart
#       
      # Return: array of CartPaymentMethodEntity - an array with list of available payment methods
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