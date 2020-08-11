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
    students = {}
    page = Nokogiri::HTML(open(profile_url))
    page.css("div.social-icon-controler a").each do |student|
      desired_url = student.attribute("href")
        if desired_url.include?("twitter")
          students[:twitter] = desired_url
        end
    end
    students
  end
end

