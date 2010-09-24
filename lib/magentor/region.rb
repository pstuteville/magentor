module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/directory_region
  class Region < Base
    class << self
      # directory_region.list
      # List of regions in specified country
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # string $country - Country code in ISO2 or ISO3
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
      
      def find_by_country(iso)
        list(iso)
      end
    end
  end
end
