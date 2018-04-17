require 'rack'
require 'digest/md5'
require 'base64'
require "faraday"

require_relative 'rest/endpoints'
require_relative 'rest/methods'
require_relative 'rest/clients'

module Huobipro
  module Client
    class REST
      BASE_URL = 'https://api.huobipro.com/'.freeze

      def initialize(access_key: '', secret_key: '', signature_version: '')
        @access_key = access_key
        @secret_key = secret_key
        @signature_version = signature_version
        adapter = Faraday.default_adapter
        @clients = {}
        @clients[:public]   = public_client adapter
      end

      METHODS.each do |method|
        define_method(method[:name]) do |options = {}|
          client = @clients[method[:client]]
          response = client.send(method[:action]) do |req|
            sign_request(req, ENDPOINTS[method[:endpoint]], options)
            req.params.merge! options
          end
          response.body
        end
      end

      private
      def sign_request(request, path, params)
        h =  {
          "AccessKeyId"=>@access_key,
          "SignatureMethod"=>"HmacSHA256",
          "SignatureVersion"=>@signature_version,
          "Timestamp"=> Time.now.getutc.strftime("%Y-%m-%dT%H:%M:%S")
        }
        h = h.merge(params) if request.method == :get
        request_method = request.method == :get ? "GET" : "POST"
        data = "#{request_method}\napi.huobipro.com\n#{path}\n#{Rack::Utils.build_query(hash_sort(h))}"
        h["Signature"] = sign(data)
        request.url "https://api.huobipro.com#{path}?#{Rack::Utils.build_query(h)}"
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
