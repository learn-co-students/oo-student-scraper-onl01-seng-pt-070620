require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))

    students = []

    data.css(".student-card").collect do |s|
      students << {
        name: s.css("h4.student-name").text,
        location: s.css("p.student-location").text,
        profile_url: s.css("a").attribute("href").value
      }
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    info = Nokogiri::HTML(open(profile_url))

    profile = {}

    info.css(".social-icon-container").collect do |p|
      if p.include?("twitter")
          profile[:twitter] = 
    
  end

end

