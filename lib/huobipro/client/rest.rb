require 'httparty'
require 'json'
require 'open-uri'
require 'rack'
require 'digest/md5'
require 'base64'

require_relative 'rest/endpoints'
require_relative 'rest/methods'

module Huobipro
  module Client
    class REST
      BASE_URL = 'https://api.huobipro.com/'.freeze

      def initialize(access_key: '', secret_key: '', signature_version: '')
        @access_key = access_key
        @secret_key = secret_key
        @signature_version = signature_version
        @uri = URI.parse BASE_URL
        @header = {
          'Content-Type'=> 'application/json',
          'Accept' => 'application/json',
          'Accept-Language' => 'zh-CN',
          'User-Agent'=> 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
        }
      end

      METHODS.each do |method|
        define_method(method[:name]) do |options = {}|
          send_request(method[:action], ENDPOINTS[method[:endpoint]], options)
        end
      end

      private
      def send_request(request_method, path, params)
        h =  {
          "AccessKeyId"=>@access_key,
          "SignatureMethod"=>"HmacSHA256",
          "SignatureVersion"=>@signature_version,
          "Timestamp"=> Time.now.getutc.strftime("%Y-%m-%dT%H:%M:%S")
        }
        h = h.merge(params) if request_method == "GET"
        data = "#{request_method}\napi.huobipro.com\n#{path}\n#{Rack::Utils.build_query(hash_sort(h))}"
        puts data
        h["Signature"] = sign(data)
        url = "https://api.huobipro.com#{path}?#{Rack::Utils.build_query(h)}"
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = true
        begin
          JSON.parse http.send_request(request_method, url, JSON.dump(params),@header).body
        rescue Exception => e
          {"message" => 'error' ,"request_error" => e.message}
        end
      end

      def sign(data)
        Base64.encode64(OpenSSL::HMAC.digest('sha256',@secret_key,data)).gsub("\n","")
      end

      def hash_sort(ha)
        Hash[ha.sort_by{|key, val|key}]
      end
    end
  end
end
