require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |object|
      {:name => object.css(".student-name").text, 
      :location => object.css(".student-location").text,
      :profile_url => object.attr('href')}
    
    end
  end
  

  def self.scrape_profile_page(profile_url)
  
    
    
  end

end

