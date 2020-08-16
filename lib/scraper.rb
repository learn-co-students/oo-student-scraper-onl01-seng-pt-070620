require_relative "../lib/student.rb"
require_relative "../config.rb"
require 'open-uri'
require 'pry'

class Scraper

  URL = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css(".student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css("h4").text
      student_info [:location] = student.css("p").text
      student_info [:profile_url] = student.css("a").attribute("href").value 
    
      students << student_info
    end
      students
  end
 
  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    profile = Nokogiri::HTML(open(profile_url))
  
    links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}

    links.each do |link|
      if link.include?("twitter")
        scraped_student[:twitter] = link
      elsif link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      else
        scraped_student[:blog] = link
      end
      scraped_student[:profile_quote] = profile.css(".profile-quote").text
      scraped_student[:bio] = profile.css(".bio-content p").text
    end
      scraped_student
  end

end


    


