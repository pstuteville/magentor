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

    def multicall(*calls)
      multicall_without_caching(*calls)
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

      def multicall_without_caching(*calls)
        logger.debug "multicall: #{calls.inspect}"
        connect
        retry_on_connection_error do
          ret = client.call_async("multiCall", session, [*calls])
          ret.each do |e|
            if e.class == Hash and e["isFault"] then
              logger.debug "exception: #{e["faultCode"]} -> #{e["faultMessage"]}"
            end
          end
          return ret
        end
      rescue XMLRPC::FaultException => e
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
          retry if attempts < 3
        rescue RuntimeError
          attempts += 1
          retry if attempts < 3
        end
      end
  end
end
