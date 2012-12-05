#!/bin/env ruby
# encoding: utf-8
# Author: kimoto
require 'amazon_dp'

#page_info = AmazonDP.get("B00A3EXJP6")
AmazonDP.logger = Logger.new(STDERR)
page_info = AmazonDP.get("AAAA")
p page_info

