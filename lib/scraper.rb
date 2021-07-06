require 'open-uri'
require 'pry'
require 'nokogiri'
require_relative './student.rb'


class Scraper

  def self.scrape_index_page(index_url)
    
    scraped_students = []
    
      doc = Nokogiri::HTML(open(index_url))
    
      doc.css(".student-card a").each do |s|
        profile_url = s.attr('href')
        name = s.css('.student-name').children.text
        location = s.css('.student-location').children.text 
        scraped_students << {:name => name, :location => location, :profile_url =>profile_url} 
    end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css('a').map {|el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("twitter")
        student[:twitter] = link 
      elsif link.include?("github")
        student[:github] = link
      else 
        student[:blog] = link
      end
    end

    student[:profile_quote] = profile_page.css('.profile-quote').text if profile_page.css('.profile-quote')
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
    
  end

end

