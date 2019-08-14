require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
    all_cards = doc.css(".student-card")
    all_cards.each do |card|
      array << {:name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => card.css("a").attribute("href").value}
    end
    array
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    social = doc.css("a")
    
    array = []
    
    social.each do |item|
      array << item.attribute("href").value
    end

    hash = {twitter: array.select{|item| item.include?("twitter")}.first,
    linkedin: array.select{|item| item.include?("linkedin")}.first,
    github: array.select{|item| item.include?("github")}.first,
    blog: array.select{|item| item.include?("joe")}.first,
    profile_quote: doc.css(".profile-quote").text,
    bio: doc.css("p").text}
    hash.compact
  end
end