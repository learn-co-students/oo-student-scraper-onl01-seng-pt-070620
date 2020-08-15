require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    info = index_page.css(".student-card a").collect do |student|
    student_index = {
      :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attr('href')
    }
    end
  end
 
  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map {|l| l.attribute("href").value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link 
      elsif link.include?("github")
        student[:github] = link 
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link 
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
  student 
  end

end

