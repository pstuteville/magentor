module Magento
  class Inventory < Base
    class << self
      def api_path
        "product_stock"
      end

      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
    end
  end
end
