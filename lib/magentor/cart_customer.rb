module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1041   Customer is not set.
  # 1042   The customer’s identifier is not valid or customer is not existed
  # 1043   Customer could not be created.
  # 1044   Customer data is not valid.
  # 1045   Customer’s mode is unknown
  # 1051   Customer address data is empty.
  # 1052   Customer’s address data is not valid.
  # 1053   The customer’s address identifier is not valid
  # 1054   Customer address is not set.
  # 1055   Customer address identifier do not belong customer, which set in quote
  class CartCustomer < Base
    class << self      
      
      # cart_customer.set
      # Add Customer Information into shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # CartCustomerEntity customerData - an associative array with customer information
      # mixed (int | string) storeView - Store view Id or code (optional)
      def set(*args)
        commit('set', *args)
      end

      # cart_customer.addresses
      # Set customer’s addresses (shipping, billing) in shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # array of CartCustomerAddressEntity customerAddressData - an array with list of CartCustomerAddressEntity
      # mixed (int | string) storeView - Store view Id or code (optional)
      def addresses(*args)
        commit("addresses", *args)
      end
    end
  end
end