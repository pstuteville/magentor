module Magentor
  # http://www.magentocommerce.com/wiki/doc/webservices-api/api/catalog_product_attribute_media
  # 100  Requested store view not found.
  # 101  Product not exists.
  # 102  Invalid data given. Details in error message.
  # 103  Requested image not exists in product images’ gallery.
  # 104  Image creation failed. Details in error message.
  # 105  Image not updated. Details in error message.
  # 106  Image not removed. Details in error message.
  # 107  Requested product doesn’t support images
  class ProductMedia < Base
    class << self
      # catalog_product_attribute_media.list
      # Retrieve product image list
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # mixed product - product ID or Sku
      # mixed storeView - store view ID or code (optional)
      def list(*args)
        results = commit("list", *args)
        results.collect do |result|
          new(result)
        end
      end

      # catalog_product_attribute_media.create
      # Upload new product image
      # 
      # Return: string - image file name
      # 
      # Arguments:
      # 
      # mixed product - product ID or code
      # array data - image data. requires file content in base64, and image mime-type. 
      #   Example: array(’file’ ⇒ array(’content’ ⇒ base64_encode($file), ‘mime’ ⇒ ‘type/jpeg’)
      #   mixed storeView - store view ID or code (optional)
      def create(*args)
        id = commit("create", *args)
        record = info(id)
        record
      end

      # catalog_product_attribute_media.info
      # Retrieve product image data
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # mixed product - product ID or Sku
      # string file - image file name
      # mixed storeView - store view ID or code (optional)
      def info(*args)
        new(commit("info", *args))
      end

      # catalog_product_attribute_media.update
      # Update product image
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # mixed product - product ID or code
      # string file - image file name
      # array data - image data (label, position, exclude, types)
      # mixed storeView - store view ID or code (optional)
      def update(*args)
        commit("update", *args)
      end

      # catalog_product_attribute_media.remove
      # Remove product image
      # 
      # Return: boolean
      # 
      # Arguments:
      # 
      # mixed product - product ID or Sku
      # string file - image file name
      def remove(*args)
        commit("remove", *args)
      end

      # catalog_product_attribute_media.currentStore
      # Set/Get current store view
      # 
      # Return: int
      # 
      # Arguments:
      # 
      # mixed storeView - store view code or ID (optional)
      def current_store(*args)
        commit("currentStore", *args)
      end

      # catalog_product_attribute_media.types
      # Retrieve product image types (image, small_image, thumbnail, etc...)
      # 
      # Return: array
      # 
      # Arguments:
      # 
      # int setId - product attribute set ID
      def types(*args)
        commit("types", *args)
      end
      
      def find_by_product_id_or_sku(id)
        list(id)
      end
    end
    
    # def delete
    #   # TODO: get actual field names for product and file
    #   self.class.remove(self.product, self.file)
    # end
  end
end 