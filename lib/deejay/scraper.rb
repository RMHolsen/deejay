require 'nokogiri'
require 'pry'
require 'open-uri'

class Scraper
    def self.scrape_album(url)
        tags = []
        album = Nokogiri::HTML(open(url))
        album.css(".tralbum-tags .tag").each do |tag|
        tags << tag.text
        end 
        tags
        #This needs to return an array of the album tags
        
    end 

    def self.scrape_tag(genre)
        genre = genre.gsub(" ", "-")
        genre_page = Nokogiri::HTML(open("https://bandcamp.com/tag/#{genre}#"))
        #Should pull the selected genre and turn it into a URL bandcamp accepts
    
        artists = []
        genre_page.css(".info .artist").each do |artist|
          artists << artist.text.gsub("by ", "").strip
          #Don't forget to take out the whitespace
        end 
        artists.uniq
        #binding.pry
    end 

end  
