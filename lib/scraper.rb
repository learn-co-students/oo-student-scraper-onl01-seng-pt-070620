require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    page = doc.css('div.roster-cards-container')
    hashArray = []
    page.each do |container|
      page.css('.student-card').each do |name|
        username = name.css('.student-name').text
        location = name.css('.student-location').text
        url = name.css('a').attribute('href').text
        temporaryHash = Hash.new.tap do |hash|
          hash[:name] = username
          hash[:location] = location
          hash[:profile_url] = url
        end
        hashArray << temporaryHash
      end
    end
    hashArray
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    quote = doc.css('div.profile-quote').text
    bio =  doc.css('div.description-holder p').text
    page = doc.css('div.social-icon-container')
    hashProfile = Hash.new
    page.css('a').each do |link|
      linksplit = link.attribute('href').text.gsub("www.", "").split("//").last.split(".").first # just get middle of url
      hashProfile.tap do |hash|
        linksplit = 'blog' unless ['twitter', 'github', 'linkedin'].include?(linksplit)
        hash[linksplit.to_sym] = link.attribute('href').text
        hash[:bio] = bio
        hash[:profile_quote] = quote
      end
    end
    hashProfile
  end
end

