#!/bin/env ruby
# encoding: utf-8
# Author: kimoto
require 'amazon_dp'

AmazonDP::Fetcher.logger = Logger.new(STDERR)
AmazonDP::Parser.logger = Logger.new(STDERR)

fetcher = AmazonDP::Fetcher.new
fetcher.adult_auth

parser = AmazonDP::Parser.new

page_data = fetcher.fetch("http://www.amazon.co.jp/dp/4894714078")
page_info = parser.parse_html(page_data)
p page_info

page_data = fetcher.fetch("http://www.amazon.co.jp/dp/B00A40XOU4/")
p page_info = parser.parse_html(page_data)

page_data = fetcher.fetch("B00A3EXJP6")
p page_info = parser.parse_html(page_data)

