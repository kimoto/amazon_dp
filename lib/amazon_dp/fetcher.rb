#!/bin/env ruby
# encoding: utf-8
# Author: kimoto
require 'nokogiri'
require 'mechanize'
require 'logger'

module AmazonDP
  class Fetcher
    ADULT_AUTH_URL = "http://www.amazon.co.jp/gp/product/black-curtain-redirect.html"
    PERMALINK_URL = "http://www.amazon.co.jp/gp/product/[ASIN_CODE]?ie=UTF8&redirect=true"
    USER_AGENT = "w3m/0.5.2"

    @@logger = Logger.new(nil)
    def self.logger=(logger)
      @@logger = logger
    end

    def initialize(opts={})
      @user_agent = opts[:user_agent] ? opts[:user_agent] : USER_AGENT
      @adult_auth_url = opts[:adult_auth_url] ? opts[:adult_auth_url] : ADULT_AUTH_URL
      @permalink_url = opts[:permalink_url] ? opts[:permalink_url] : PERMALINK_URL
      @agent = Mechanize.new{ |agent|
        agent.user_agent = @user_agent
      }
    end

    def adult_auth
      @@logger.info "try adult authentication"
      @agent.redirect_ok = false
      page = @agent.get(@adult_auth_url)
      @agent.redirect_ok = true
      @@logger.info "adult authentication done"
    end

    def fetch(*params)
      if params == /^https?/
        fetch_url(*params)
      else
        fetch_asin_code(*params)
      end
    end

    private
    def fetch_asin_code(asin_code)
      fetch_url @permalink_url.clone.gsub("[ASIN_CODE]", asin_code)
    end

    def fetch_url(url)
      @@logger.info "try fetch information: #{url}"
      page = @agent.get(url)
      @@logger.info "fetched"
      page.body
    end
  end
end
