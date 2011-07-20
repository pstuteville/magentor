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
      retry_on_connection_error do
        @session = @client.call("login", config[:username], config[:api_key])
      end
    end
    
    def call(method = nil, *args)
      @logger.debug "call: #{method}, #{args.inspect}"
      connect
      retry_on_connection_error do
        @client.call("call", @session, method, args)
      end
    rescue XMLRPC::FaultException => e
      @logger.debug "exception: #{e.faultCode} -> #{e.faultString}"
      raise Magento::ApiError, "#{e.faultCode} -> #{e.faultString}"
    end

    private

      def retry_on_connection_error
        attempts = 0
        begin
          yield
        rescue EOFError
          attempts += 1
          retry if attempts < 2
        end
      end
  end
end
