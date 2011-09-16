module Magento
  class Connection 
    attr_accessor :session, :config, :logger

    def initialize(config = {})
      @logger ||= Logger.new(STDOUT)
      @config = config
      self
    end

    def client
      @client ||= XMLRPC::Client.new(config[:host], config[:path], config[:port])
    end

    def connect
      connect! if session.nil?
    end

    def call(method = nil, *args)
      logger.debug "call: #{method}, #{args.inspect}"
      connect
      client.call("call", session, method, args)
    rescue XMLRPC::FaultException => e
      logger.debug "exception: #{e.faultCode} -> #{e.faultString}"
      if e.faultCode == 5 # Session timeout
        connect!
        retry
      end
      raise Magento::ApiError, "#{e.faultCode} -> #{e.faultString}"
    end

    private

      def connect!
        logger.debug "call: login"
        @session = client.call("login", config[:username], config[:api_key])
      end
  end
end
