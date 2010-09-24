module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/customer_group
  class CustomerGroup < Base
    class << self
      # customer_group.list
      # Retrieve customer groups
      # 
      # Return: array
      def list
        results = commit("list", nil)
        results.collect do |result|
          new(result)
        end
      end
    end
  end
end