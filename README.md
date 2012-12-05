# AmazonDP

Amazon Description of Product page parser

## Installation

Add this line to your application's Gemfile:

    gem 'amazon_dp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amazon_dp

## Usage

    #1
    require 'amazon_dp'
    page_info = AmazonDP.get("http://www.amazon.co.jp/dp/ASIN_CODE")

    #2
    require 'amazon_dp'
    page_info = AmazonDP.get("ASIN_CODE")

    #3
    require 'amazon_dp'
    f = AmazonDP::Fetcher.new
    f.adult_auth
    html = f.fetch("URL_OR_ASIN_CODE")
    page_info = AmazonDP::Parser.new.parse_html(html)

