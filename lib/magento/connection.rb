require 'logger'

module Magento
  class Connection 
    attr_accessor :client, :config, :logger
    def initialize(config = {})
      @logger ||= Logger.new(STDOUT)
      @config = config
      self
    end
    
    def connect
      @client = XMLRPC::Client.new(config[:host], config[:path], config[:port])
      @session = @client.call("login", config[:username], config[:api_key])
    end
    
    def call(method = nil, *args)
      @logger.debug "call: #{method}, #{args.inspect}"
      connect
      @client.call("call", @session, method, args)
    rescue XMLRPC::FaultException => e
      @logger.debug "exception: #{e.faultCode} -> #{e.faultString}"
      raise Magento::ApiError, "#{e.faultCode} -> #{e.faultString}"
    end
  end
end
