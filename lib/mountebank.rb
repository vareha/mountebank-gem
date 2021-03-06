require "mountebank/version"
require "mountebank/helper"
require "mountebank/network"
require "mountebank/imposter"
require "mountebank/stub"
require "mountebank/stub/response"
require "mountebank/stub/http_response"
require "mountebank/stub/https_response"
require "mountebank/stub/tcp_response"
require "mountebank/stub/proxy_response"
require "mountebank/stub/predicate"
require "json"

module Mountebank
  extend self

  def self.imposters
    imposters = []

    response = Network.get('/imposters')
    if response.success?
      response.body[:imposters].each do |imposter|
        imposters << Mountebank::Imposter.new(imposter)
      end
    end

    imposters
  end

  def self.reset
    response = Network.delete('/imposters')
    response.success?
  end
end
