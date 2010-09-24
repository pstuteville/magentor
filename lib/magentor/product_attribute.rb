module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/catalog_product_attribute
  # 100  Requested store view not found.
  # 101  Requested attribute not found.
  class ProductAttribute < Base
    class << self
      # catalog_product_attribute.list
      # Retrieve attribute list
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # int setId - attribute set ID
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end

      # catalog_product_attribute.currentStore
      # Set/Get current store view
      # 
      # Return: int
      # 
      # Arguments:
      # 
      # mixed storeView - store view id or code (optional)
      def current_store(*args)
        commit("currentStore", *args)
      end


      # catalog_product_attribute.options
      # Retrieve attribute options
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # mixed attributeId - attribute ID or code
      # mixed storeView - store view ID or code (optional)
      def options(*args)
        commit("options", *args)
      end
    end
  end
end