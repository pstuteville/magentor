module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/directory_country
  class Country < Base
    class << self
      # directory_country.list
      # Retrieve list of countries.
      # 
      # Return: array.
      def list
        results = commit("list", nil)
        results.collect do |result|
          new(result)
        end
      end
      
      def all
        list
      end
    end
  end
end