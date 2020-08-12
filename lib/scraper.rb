require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []

    page.css("div.student-card").each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      student_url = student.css("a").attribute("href").value
      student_profile = {
        :name => student_name,
        :location => student_location,
        :profile_url => student_url
      }
      students << student_profile
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    profile = page.css("div.social-icon-container a").collect{|icon| icon.attribute("href").value}
    profile.each do |url|
      if url.include?("twitter")
        student[:twitter] = url
      elsif url.include?("linkedin")
        student[:linkedin] = url
      elsif url.include?("github")
        student[:github] = url
      elsif url.include?(".com")
        student[:blog] = url
      end
      end
    student[:profile_quote] = page.css("div.profile-quote").text
    student[:bio] = page.css("div.bio-content p").text
    student
  end
end