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
      cache? ? call_with_caching(method, *args) : call_without_caching(method, *args)
    end

    private

      def cache?
        !!config[:cache_store]
      end

      def call_without_caching(method = nil, *args)
        @logger.debug "call: #{method}, #{args.inspect}"
        connect
        @client.call("call", @session, method, args)
      rescue XMLRPC::FaultException => e
        @logger.debug "exception: #{e.faultCode} -> #{e.faultString}"
        raise Magento::ApiError, "#{e.faultCode} -> #{e.faultString}"
      end

      def call_with_caching(method = nil, *args)
        config[:cache_store].fetch(cache_key(method, *args)) do
          call_without_caching(method, *args)
        end
      end

      def cache_key(method, *args)
        "#{config[:username]}@#{config[:host]}:#{config[:port]}#{config[:path]}/#{method}/#{args.inspect}"
      end
  end
end
