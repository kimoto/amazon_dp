#!/bin/env ruby

module AmazonDP
  def self.get(url_or_asin)
    f = Fetcher.new
    f.adult_auth
    Parser.new.parse_html f.fetch(url_or_asin)
  end
end

