class Scraper
    def self.scrape_album(url)
        tags = []
        album = Nokogiri::HTML(open(url))
        album.css(".tralbum-tags").each do |tag|
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
        doc.css(".info .artist").each do |artist|
          artists << artist.text.gsub("by ", "")
        end 
        artists.uniq
        #After this the case options shouldn't be necessary
        #But you'll have to format the data output
    end 

end  
