module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cataloginventory_stock_item
  # 101  Product not exists.
  # 102  Product inventory not updated. Details in error message.
  class ProductStock < Base
    class << self
      # cataloginventory_stock_item.list
      # Retrieve stock data by product ids
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # array products - list of products IDs or Skus
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
            
      # cataloginventory_stock_item.update
      # Update product stock data
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # mixed product - product ID or Sku
      # array data - data to change (qty, is_in_stock)
      def update(*args)
        commit('update', *args)
      end
    end
  end
end