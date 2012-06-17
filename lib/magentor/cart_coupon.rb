module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1081   Coupon could not be applied because quote is empty.
  # 1082   Coupon could not be applied.
  # 1083   Coupon is not valid.
  class CartCoupon < Base
    class << self      

      # cart_coupon.add
      # Add coupon (code) to Quote
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # string couponCode - coupon code
      # mixed (int | string) storeView - Store view Id or code (optional)
      def add(*args)
        commit('add', *args)
      end

      # cart_coupon.remove
      # Remove coupon (code) from Quote
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def remove(*args)
        commit('remove', *args)
      end
    end
  end
end