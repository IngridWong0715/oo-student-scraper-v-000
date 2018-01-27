require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    # students_collection = []
    #
    # students.each do |student|
    #   student_hash = {}
    #   student_hash[:profile_url] = student.css("a[href]").first.attributes["href"].value
    #   student_hash[:name] = student.css(".student-name").text
    #   student_hash[:location] = student.css(".student-location").text
    #   students_collection << student_hash
    #
    # end
    # students_collection

    students.inject([]) do |acc, student|
      student_hash = {}
      student_hash[:profile_url] = student.css("a[href]").first.attributes["href"].value
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      acc << student_hash
    end
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

      profile_info = {}
    social = profile.css(".social-icon-container a")

    social.each do |account|
      attribute = account.attributes["href"].value.split(".")[1]
      profile_info[attribute] = account.attributes["href"].value
    end

 binding.pry

     profile_info[:twitter] = profile.css(".social-icon-container a:first-child").first.attributes["href"].value
      profile_info[:linkedin] = profile.css(".social-icon-container a:nth-child(2)").first.attributes["href"].value
      profile_info[:github] = profile.css(".social-icon-container a:nth-child(3)").first.attributes["href"].value
      profile_info[:blog] = profile.css(".social-icon-container a:last-child").first.attributes["href"].value
      profile_info[:profile_quote] = profile.css(".profile-quote").text
      profile_info[:bio] = profile.css(".description-holder p").text
      binding.pry
    profile_info

    #   binding.pry
      #linkedin: profile.css(".social-icon-container a:nth-child(2)").first.attributes["href"].value
      # github:profile.css(".social-icon-container a:nth-child(3)").first.attributes["href"].value
      # blog:profile.css(".social-icon-container a:last-child").first.attributes["href"].value
      # profile_quote:profile.css(".profile-quote").text
      # bio:profile.css(".description-holder p").text


  end

end
