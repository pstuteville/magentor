# Ruby wrapper for the magento api
#
# Author::    Preston Stuteville  (mailto:preston.stuteville@gmail.com)
# License::   MIT
#
# Inspiration from the Magento plugin from Tim Matheson (http://github.com/timmatheson/Magento) 
       
require 'magento/connection'

#require 'xmlrpc'
require 'xmlrpc/client'

require 'magento/base'

XMLRPC::Config.send(:remove_const, :ENABLE_NIL_PARSER)
XMLRPC::Config.send(:const_set, :ENABLE_NIL_PARSER, true)
XMLRPC::Config.send(:remove_const, :ENABLE_NIL_CREATE)
XMLRPC::Config.send(:const_set, :ENABLE_NIL_CREATE, true)