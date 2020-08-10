require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio
  @@students = []
  # @@student_profiles = {}
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    times_to_loop = doc.css("div.student-card").size
    i = 0
    
    doc.css("div.roster-cards-container").each do |student|
      times_to_loop.times do 
        @@students.push({
          location: student.css('p.student-location')[i].inner_html, 
          name: student.css('h4.student-name')[i].inner_html, 
          profile_url: student.css('.student-card a')[i].attribute('href').value })
        i = i + 1
      end
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
   
   all_students = doc.css(".social-icon-container a").collect {|icon| icon.attribute('href').value}
    
    all_students.each do |link|
      if link.include?('twitter')
        student[:twitter] = link
      elsif link.include?('linkedin')
        student[:linkedin] = link 
      elsif link.include?('github')
        student[:github] = link
      elsif link.include?('.com')
        student[:blog] = link
      end
    end
    
    student[:bio] = doc.css('.description-holder p').inner_html
    student[:profile_quote] = doc.css('.profile-quote').inner_html
    student
  end
end
