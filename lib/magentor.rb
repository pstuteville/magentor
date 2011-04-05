# Ruby wrapper for the magento api
#
# Author::    Preston Stuteville  (mailto:preston.stuteville@gmail.com)
# License::   MIT
#
# Inspiration from the Magento plugin from Tim Matheson (http://github.com/timmatheson/Magento) 

require "active_support/inflector"
require "logger"
require 'xmlrpc/client'

XMLRPC::Config.send(:remove_const, :ENABLE_NIL_PARSER)
XMLRPC::Config.send(:const_set, :ENABLE_NIL_PARSER, true)
XMLRPC::Config.send(:remove_const, :ENABLE_NIL_CREATE)
XMLRPC::Config.send(:const_set, :ENABLE_NIL_CREATE, true)

require 'magento/connection'
require 'magento/base'

module Magento
  autoload :CategoryAttribute,   "magento/category_attribute"
  autoload :Category,            "magento/category"
  autoload :Country,             "magento/country"
  autoload :CustomerAddress,     "magento/customer_address"
  autoload :CustomerGroup,       "magento/customer_group"
  autoload :Customer,            "magento/customer"
  autoload :Inventory,           "magento/inventory"
  autoload :Invoice,             "magento/invoice"
  autoload :OrderItem,           "magento/order_item"
  autoload :Order,               "magento/order"
  autoload :ProductAttribute,    "magento/product_attribute"
  autoload :ProductAttributeSet, "magento/product_attribute_set"
  autoload :ProductLink,         "magento/product_link"
  autoload :ProductMedia,        "magento/product_media"
  autoload :Product,             "magento/product"
  autoload :ProductStock,        "magento/product_stock"
  autoload :ProductTierPrice,    "magento/product_tier_price"
  autoload :ProductType,         "magento/product_type"
  autoload :Region,              "magento/region"
  autoload :Shipment,            "magento/shipment"
end
