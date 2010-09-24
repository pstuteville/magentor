module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/sales_order_invoice
  # 100  Requested shipment does not exists.
  # 101  Invalid filters given. Details in error message.
  # 102  Invalid data given. Details in error message.
  # 103  Requested order does not exists
  # 104  Invoice status not changed.
  class Invoice < Base
    class << self      
      # sales_order_invoice.list
      # Retrieve list of invoices by filters
      # 
      # Return: array Arguments:
      # 
      # array filters - filters for invoices list (optional)
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end
      
      # sales_order_invoice.info
      # Retrieve invoice information
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # string invoiceIncrementId - invoice increment id
      def info(*args)
        new(commit("info", *args))
      end
      
      # sales_order_invoice.create
      # Create new invoice for order
      # 
      # Return: string
      # 
      # Arguments:
      # 
      # string orderIncrementId - order increment id
      # array itemsQty - items qty to invoice
      # string comment - invoice comment (optional)
      # boolean email - send invoice on e-mail (optional)
      # boolean includeComment - include comments in e-mail (optional)
      def create(*args)
        id = commit("create", *args)
        record = info(id)
        record
      end
      
      # sales_order_invoice.addComment
      # Add new comment to shipment
      # 
      # Arguments:
      # 
      # string invoiceIncrementId - invoice increment id
      # string comment - invoice comment
      # boolean email - send invoice on e-mail (optional)
      # boolean includeComment - include comments in e-mail (optional)
      def add_comment(*args)
        commit('addComment', *args)
      end
      
      # sales_order_invoice.capture
      # Capture invoice
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string invoiceIncrementId - invoice increment id
      # 
      # Notes:
      # 
      # You should check the invoice to see if can be captured before attempting to capture an invoice, 
      # otherwise the API call with generate an error.
      # 
      # Invoices have states as defined in the model Mage_Sales_Model_Order_Invoice:
      # 
      # STATE_OPEN = 1
      # STATE_PAID = 2
      # STATE_CANCELED = 3
      # Also note there is a method call in the model that checks this for you canCapture(), and it also 
      # verifies that the payment is able to be captured, so the invoice state might not be the only 
      # condition that’s required to allow it to be captured.
      def capture(*args)
        commit('capture', *args)
      end
      
      # sales_order_invoice.void
      # Void invoice
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string invoiceIncrementId - invoice increment id
      def void(*args)
        commit('void', *args)
      end
      
      # sales_order_invoice.cancel
      # Cancel invoice
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # string invoiceIncrementId - invoice increment id
      def cancel(*args)
        commit('cancel', *args)
      end
      
      def find_by_id(id)
        info(id)
      end

      def find(find_type, options = {})
        filters = {}
        options.each_pair { |k, v| filters[k] = {:eq => v} }
        results = list(filters)
        if find_type == :first
          results.first
        else
          results
        end
      end
    end
  end
end