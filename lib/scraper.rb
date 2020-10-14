require 'pry'



class Scraper
    def self.scrape_album(url)
        tags = []
        #album = Nokogiri::HTML(open(url))
        #album.css(".tralbumData tralbum-tags tralbum-tags-nu").children.css("a").text.each do |tag|
        #tags << tag
        #end 
        #tags
        #Okay no, can't test the scraping method just yet
        #This needs to return an array of the album tags
        
    end 

    def self.scrape_tag(genre)
        #artists = []
        #genre = genre.gsub(" ", "-")
        #genre_page = Nokogiri::HTML(open(https://bandcamp.com/tag/#{genre}))
    

        #genre_page.css(".info .artist?").text.each.do |name|
        #artists << name
        #end
        #artists.uniq
        #After this the case options shouldn't be necessary
        #But you'll have to format the data output
        
        case genre
        when "folk rock" 
            puts "\n1. The Mechanisms"
            puts "2. The Left Outsides"
            puts "3. The Oh Hellos"
        when "urban folk"
            puts "\n1. Khalil Anthony"
            puts "2. Maia Banks"
            puts "3. Igor Spolski"
        when "alt-folk"
            puts "\n 1. Rowan Morrison"
            puts "2. Miles Benson"
            puts "3. Crake"
            puts "4. Weather Balloons"
        when "folk"
            puts "\n1. Nickel Creek"
            puts "2.  Phoebe Bridgers"
            puts "3. Richard Thompson"
        end 
    end 

end 