
require 'faraday_middleware'

module Huobipro
  module Client
    class REST
      def public_client(adapter)
        Faraday.new(url: "#{BASE_URL}") do |conn|
          conn.request :json
          conn.response :json, content_type: /\bjson$/
          conn.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
          conn.adapter adapter
        end
      end

      # def public_client(adapter)
      #   Faraday.new(url: "#{BASE_URL}/api") do |conn|
      #     conn.request :json
      #     conn.response :json, content_type: /\bjson$/
      #     conn.adapter adapter
      #   end
      # end

      # def verified_client(api_key, adapter)
      #   Faraday.new(url: "#{BASE_URL}/api") do |conn|
      #     conn.response :json, content_type: /\bjson$/
      #     conn.headers['X-MBX-APIKEY'] = api_key
      #     conn.adapter adapter
      #   end
      # end

      # def signed_client(api_key, secret_key, adapter)
      #   Faraday.new(url: "#{BASE_URL}/api") do |conn|
      #     conn.request :json
      #     conn.response :json, content_type: /\bjson$/
      #     conn.headers['X-MBX-APIKEY'] = api_key
      #     conn.use TimestampRequestMiddleware
      #     conn.use SignRequestMiddleware, secret_key
      #     conn.adapter adapter
      #   end
      # end

      # def public_withdraw_client(adapter)
      #   Faraday.new(url: "#{BASE_URL}/wapi") do |conn|
      #     conn.request :json
      #     conn.response :json, content_type: /\bjson$/
      #     conn.adapter adapter
      #   end
      # end

      # def withdraw_client(api_key, secret_key, adapter)
      #   Faraday.new(url: "#{BASE_URL}/wapi") do |conn|
      #     conn.request :url_encoded
      #     conn.response :json, content_type: /\bjson$/
      #     conn.headers['X-MBX-APIKEY'] = api_key
      #     conn.use TimestampRequestMiddleware
      #     conn.use SignRequestMiddleware, secret_key
      #     conn.adapter adapter
      #   end
      # end
    end
  end
end