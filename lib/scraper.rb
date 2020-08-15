require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    info = index_page.css(".student-card").each do |student|
    student_index = {
      :name => index_page.css(".student_name")
    } 
  end
  
  # projects = {}
  # kickstarter.css("li.project.grid_4").each do |project|
  #   title = project.css("h2.bbcard_name strong a").text
  #   projects[title.to_sym] = {
  #     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  #     :description => project.css("p.bbcard_blurb").text,
  #     :location => project.css("ul.project-meta span.location-name").text,
  #     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  #   }
  # end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
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
  student_profile  
  end

end

