require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page")
    doc = Nokogiri::HTML(html)
    students = []
    doc.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_link = student.attr('href')
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_page = Nokogiri::HTML(html)
    student = {}
    student[:profile_quote] = student_page.css(".profile-quote").text
    student[:bio] = student_page.css("div.bio-content.content-holder div.description-holder p").text
    links = student_page.css("div.social-icon-container").children.css("a").map do |element|
      element.attribute('href').value
    end
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
    student
  end

end

