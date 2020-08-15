require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = []

    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.roster-cards-container").each do |roster|
      roster.css("div.student-card").each do |card|
          name= card.css("h4.student-name").text
          location= card.css("p.student-location").text
          profile_url= card.xpath('//a/@href').text
          # profile_url.each do  |attr| attr.value

          # profile_url= card.css
          student << {name:name, location:location, profile_url:profile_url}
          binding.pry
      end
    end

  end

  def self.scrape_profile_page(profile_url)

  end

end

