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
        method = "#{to_s.split('::').last.underscore.downcase}.#{method}"
        Magento::Base.connection.call(method, *args)
      end
      
      def all
        list
      end
      
      def list(*args)
        results = commit("list", *args)
        Magento::Base.connection.logger.debug "\n#{results.inspect}\n"
        results.collect do |result|
          new(result)
        end
      end

      def create(attributes)
        id = commit("create", attributes)
        record = new(attributes)
        record.id = id
        record
      end
      
      def info(*args)
        # args = id
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
    
    module InstanceMethods
      def update_attribute(name, value)
        @attributes[name] = value
        self.class.update(self.id, Hash[*[name.to_sym, value]])
      end
      
      def update_attributes(attrs)
        attrs.each_pair { |k, v| @attributes[k] = v }
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
end