#!/bin/env ruby

module AmazonDP
  def self.get(url_or_asin)
    f = Fetcher.new
    f.adult_auth
    f.cero_auth
    Parser.new.parse_html f.fetch(url_or_asin)
  end
  def self.logger=(logger)
    Fetcher.logger = logger
    Parser.logger = logger
  end
end

