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
        method = "#{to_s.split('::').last.underscore.downcase}.#{method}"
        Magento::Base.connection.call(method, *args)
      end
      
      def all
        list
      end
      
      def list(*args)
        # TODO: wrap results into an array of objects populated with attributes
        results = commit("list", *args)
        Magento::Base.connection.logger.debug "\n#{results.inspect}\n"
        results.collect do |result|
          new(result)
        end
      end

      def create(*args)
        # TODO: after create, return a new object with attributes and id populated
        commit("create", *args)
      end
      
      def info(*args)
        commit("info", *args)
      end
      
      def update(*args)
        # args = id, data_array
        commit("update", *args)
      end
      
      def delete(*args)
        # args = id
        commit("delete", *args)
      end
      
      def find(options = {})
        filters = {}
        options.each_pair { |k, v| filters[k] = {:eq => v} }
        list(filters)
      end
    end
    
    module InstanceMethods
      def update_attribute(name, value)
        self.class.update(self.id, Hash[*[name, value]])
      end
      
      def update_attributes(attrs)
        self.class.update(self.id, attrs)
      end
      
      def delete
        self.class.delete(self.id)
      end
      
      def initialize(attributes = {})
        @attributes = attributes.dup
      end
      
      def id
        @attributes["#{self.class.to_s.split('::').last.underscore.downcase}_id"]
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
end