# Base Magento model handles basic crud operations and stores connection to magento instance.
# It has the following class attributes:
#
# * <tt>connection</tt>: the Magento::Connection to use
# 
# And the following instance attributes:
# * <tt>attributes</tt>: the attributes of the magento object
#
module Magento
  class Base
    attr_accessor :attributes
    class << self; attr_accessor :connection end
    
    module ClassMethods
      # Uses the classes name and method to make an rpc call through connection
      def commit(method, *args)
        # TODO: need to catch errors sent back from magento and bubble them up appropriately
        method = "#{api_path}.#{method}"
        Magento::Base.connection.call(method, *args)
      end
      
      def api_path
        to_s.split('::').last.underscore.downcase
      end
    end
    
    module InstanceMethods
      def initialize(attributes = {})
        @attributes = attributes.dup
      end
      
      # TODO: find out if the id naming is consistent
      def id
        @attributes["#{self.class.to_s.split('::').last.underscore.downcase}_id"]
      end
      
      def id=(_id)
        @attributes["#{self.class.to_s.split('::').last.underscore.downcase}_id"] = _id
      end

      def object_attributes=(new_attributes)
        return if new_attributes.nil?
        attributes = new_attributes.dup
        attributes.stringify_keys!
        attributes.each do |k, v|
          send(k + "=", v)
        end
      end

      def method_missing(method, *args)
        return nil unless @attributes
        @attributes[method.to_s]
      end
    end
    
    include InstanceMethods
    extend ClassMethods
  end

  class ApiError < StandardError; end
end