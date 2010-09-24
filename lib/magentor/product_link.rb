module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/catalog_product_link
  # 100  Given invalid link type.
  # 101  Product not exists.
  # 102  Invalid data given. Details in error message.
  # 104  Product link not removed.
  class ProductLink < Base
    class << self
      # catalog_product_link.list
      # Retrieve linked products
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # string type - link type (cross_sell, up_sell, related, grouped)
      # mixed product - product ID or Sku
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
      
      # catalog_product_link.assign
      # Assign product link
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string type - link type (up_sell, cross_sell, related, grouped)
      # mixed product - product ID or Sku
      # mixed linkedProduct - product ID or Sku for link
      # array data - link data (position, qty, etc ...) (optional)
      def assign(*args)
        commit('assign', *args)
      end
      
      # catalog_product_link.update
      # Update product link
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string type - link type (up_sell, cross_sell, related, grouped)
      # mixed product - product ID or Sku
      # mixed linkedProduct - product ID or Sku for link
      # array data - link data (position, qty, etc ...) (optional)
      def update(*args)
        commit('update', *args)
      end
            
      # catalog_product_link.remove
      # Remove product link
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string type - link type (up_sell, cross_sell, related, grouped)
      # mixed product - product ID or Sku
      # mixed linkedProduct - product ID or Sku for link
      def remove(*args)
        commit('remove', *args)
      end
      
      # catalog_product_link.types
      # Retrieve product link types
      # 
      # Return: array
      def types
        commit('types', nil)
      end
      
      # catalog_product_link.attributes
      # Retrieve product link type attributes
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # string type - link type (cross_sell, up_sell, related, grouped)
      def attributes(*args)
        commit('attributes', *args)
      end
    end
  end
end