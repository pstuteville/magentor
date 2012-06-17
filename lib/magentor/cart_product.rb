module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1021   Product’s data is not valid.
  # 1022   Product(s) could not be added.
  # 1023   Quote could not be saved during adding product(s) operation.
  # 1024   Product(s) could not be updated.
  # 1025   Quote could not be saved during updating product(s) operation.
  # 1026   Product(s) could not be removed.
  # 1027   Quote could not be saved during removing product(s) operation.
  # 1028   Customer is not set for quote.
  # 1029   Customer’s quote is not existed.
  # 1030   Quotes are identical.
  # 1031   Product(s) could not be moved.
  # 1032   One of quote could not be saved during moving product(s) operation.
  class CartProduct < Base
    class << self      
      
      # cart_product.add
      # Add product or several products into shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # array of CartProductEntity - an array with list of CartProductEntity
      # mixed (int | string) storeView - Store view Id or code (optional)
      # CartProductEntity example
#         
        # array(
        # array ('product_id' => 1, 'qty' => 2),
        # array( "sku" => "testSKU", "quantity" => 4),
        # array ('product_id' => 1, 'qty' => 2,
           # 'options' => array("2" => 'A000000')
          # ),
        # )
#         
        # note options is an array in the form of
#         
        # option_id => content
#         
        # at moment there is no way to obtain option_id from Webservice Api
      def add(*args)
        commit('add', *args)
      end
      
      # cart_product.update
      # Update product or several products into shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # array of CartProductEntity - an array with list of CartProductEntity
      # mixed (int | string) storeView - Store view Id or code (optional)
      def update(*args)
        commit("update", *args)
      end
      
      # cart_product.remove
      # Remove product or several products from shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # array of CartProductEntity - an array with list of CartProductEntity
      # mixed (int | string) storeView - Store view Id or code (optional)
      def remove(*args)
        commit("remove", *args)
      end

      # Get list of products in shopping cart
#       
      # Return: array of catalogProductEntity - an array contained list of products
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
         Product.new(result)
        end
      end
      
      # cart_product.moveToCustomerQuote
      # Move product(s) from Quote To Customer Shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # array of CartProductEntity - an array with list of CartProductEntity
      # mixed (int | string) storeView - Store view Id or code (optional)
      def move_to_customer_quote(*args)
        commit("moveToCustomerQuote", *args)
      end
    end
  end
end