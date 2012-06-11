module Magento
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/cart
  # 1001   Can not make operation because store is not exists
  # 1002   Can not make operation because quote is not exists
  # 1003   Can not create a quote.
  # 1004   Can not create a quote because quote with such identifier is already exists
  # 1005   You did not set all required agreements
  # 1006   The checkout type is not valid. Select single checkout type.
  # 1007   Checkout is not available for guest
  # 1008   Can not create an order.
  class Cart < Base
    class << self      
      
      # cart.create
      # Create a blank shopping cart
#       
      # Return: int - Shopping Card Id (Quote Id)
#       
      # Arguments:
#       
      # mixed (int | string) storeView - Store view Id or code (optional)
      def create(*args)
        id = commit("create", *args)
        record = info(id, *args)
        record
      end
      
      # cart.order
      # Create an order from shopping cart
#       
      # Return: boolean
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      # array (String) agreements - Website’s license identifiers (optional)
      def order(*args)
        commit("order", *args)
      end
      
      # cart.info
      # Get full information about current shopping cart
#       
      # Return: array (ShoppingCartEntity) - return an associate array contained information about Shopping Cart (quote)
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def info(*args)
        new(commit("info", *args))
      end
      
      # cart.totals
      # Get all available prices based on additional parameters set
#       
      # Return: array (ShoppingCartPriceEntity) - return an associate array contained information about all prices in Shopping Cart (quote)
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def totals(*args)
        commit('totals', *args)
      end

      # cart.licenseAgreement
      # Get website license agreement
#       
      # Return: array of shoppingCartLicenseEntity - list with website license
#       
      # Arguments:
#       
      # int quoteId - Shopping Cart Id (Quote Id)
      # mixed (int | string) storeView - Store view Id or code (optional)
      def license_agreement(*args)
        commit('licenseAgreement', *args)
      end
      
      def find_by_id(id)
        info(id)
      end
    end
    
    def products
      CartProduct.list(self.quote_id, self.store_id)
    end
    
    def order(license_agreements = [])
      self.class.order(self.quote_id, self.store_id, license_agreements)
    end
    
    def totals
      self.class.totals(self.quote_id, self.store_id)
    end
    
    def license_agreement
      self.class.license_agreement(self.quote_id, self.store_id)
    end
  end
end