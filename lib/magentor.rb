# Ruby wrapper for the magento api
#
# Author::    Preston Stuteville  (mailto:preston.stuteville@gmail.com)
# License::   MIT
#
# Inspiration from the Magento plugin from Tim Matheson (http://github.com/timmatheson/Magento) 
       
require 'magentor/connection'

#require 'xmlrpc'
require 'xmlrpc/client'

require 'magentor/base'

XMLRPC::Config::ENABLE_NIL_PARSER = true
XMLRPC::Config::ENABLE_NIL_CREATE = true