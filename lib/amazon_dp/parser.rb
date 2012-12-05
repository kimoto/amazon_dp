#!/bin/env ruby
# encoding: utf-8
require 'nokogiri'
require 'logger'

module AmazonDP
  class AmazonDPError < StandardError; end

  class PageInfo
    attr_accessor :is_kindle
    attr_accessor :is_adult
    attr_accessor :kindle_price
    attr_accessor :kindle_pages
    attr_accessor :stars
    attr_accessor :reviews
    attr_accessor :iine
    def initialize(opts={})
      opts.each do |k,v|
        self.send("#{k}=", v)
      end
    end
  end

  class Parser
    class ParseError < AmazonDPError; end
    class Amazon18xError < ParseError; end

    @@logger = Logger.new(nil)
    def self.logger=(logger)
      @@logger = logger
    end

    def is_adult_notice_page?(doc)
      return !doc.search("span.alert").empty?
    end

    def is_adult_product_page?(doc)
      return doc.search("span.highlight").first.children.last.text.strip == "[アダルト]"
    rescue
      return false
    end

    def is_kindle_product_page?(doc)
      return doc.search("table > tr > td > div.content > ul > li").first.children.last.text.strip == "Kindle版"
    rescue
      return false
    end

    def extract_kindle_price(doc)
      doc.search(".priceLarge").text.strip.match(/[\d.]+$/).to_s.to_f
    end

    def extract_kindle_pages(doc)
      doc.search("li.listItem > a#pageCountAvailable > span").text.strip.match(/^[\d.]+/).to_s.to_i
    end

    def extract_stars(doc)
      doc.search("span.crAvgStars > span.asinReviewsSummary > a > span.swSprite")[0].attributes["title"].value.match(/[\d.]+$/).to_s.to_f
    rescue
      nil
    end

    def extract_reviews(doc)
      doc.search("div.tiny > b").children.first.to_s.match(/^[\d.]+/).to_s.to_i
    rescue 
      nil
    end

    def extract_iine(doc)
      doc.search("span.amazonLikeCountContainer > span").children.first.to_s.gsub(/,/, "").to_i
    rescue
      nil
    end

    def parse_html(html_data)
      @@logger.info "try to parse html data"
      html_data.encode("UTF-8", "cp932")
      doc = Nokogiri::HTML(html_data)
      if is_adult_notice_page?(doc)
        @@logger.info "this page is adult amazon page"
        raise Amazon18xError
      end
      kindle_flag = is_kindle_product_page?(doc)
      return PageInfo.new(
        :is_adult => is_adult_product_page?(doc),
        :is_kindle => kindle_flag,
        :kindle_price => (kindle_flag ? extract_kindle_price(doc) : nil),
        :kindle_pages => (kindle_flag ? extract_kindle_pages(doc) : nil),
        :stars => extract_stars(doc),
        :reviews => extract_reviews(doc),
        :iine => extract_iine(doc)
      )
    end
  end
end
