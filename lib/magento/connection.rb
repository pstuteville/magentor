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
      cache? ? call_with_caching(method, *args) : call_without_caching(method, *args)
    end

    private

      def connect!
        logger.debug "call: login"
        retry_on_connection_error do
          @session = client.call("login", config[:username], config[:api_key])
        end
      end

      def cache?
        !!config[:cache_store]
      end

      def call_without_caching(method = nil, *args)
        logger.debug "call: #{method}, #{args.inspect}"
        connect
        retry_on_connection_error do
          client.call_async("call", session, method, args)
        end
      rescue XMLRPC::FaultException => e
        logger.debug "exception: #{e.faultCode} -> #{e.faultString}"
        if e.faultCode == 5 # Session timeout
          connect!
          retry
        end
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
