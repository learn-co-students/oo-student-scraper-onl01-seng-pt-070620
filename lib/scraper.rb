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
        profile[:twitter] = info.css(".social-icon-container")[0]["href"]
      elsif p.include?("linkedin")
        profile[:linkedin] = info.css(".social-icon-container")[0]["href"]
      elsif p.include?("github")
        profile[:github] = info.css(".social-icon-container")[0]["href"]
      elsif p.include?(".com")
        profile[:blog] = info.css(".social-icon-container a")[0]["href"]
      end
    end

    profile[:profile_quote] = info.css(".vitals-text-container.profile-quote").text
    profile[:bio] = info.css(".details-container.description-holder p").text

    profile
    
  end

end

