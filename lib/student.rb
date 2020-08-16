require_relative "../lib/scraper.rb"
require_relative "../config.rb"
require 'open-uri'
require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k, v|
      self.send("#{k}=", v)
    @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    # binding.pry
    attributes_hash.each do |k,v|
      self.send("#{k}=", v)
    end
  end

    def self.all
    @@all 
  end
end

