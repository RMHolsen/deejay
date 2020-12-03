require_relative "version"
require_relative "classes"
require "pry"

module Deejay2point0 
  class CLI

   #Should be CLI.rb

   #def initialize
   #Do we really need to do anything here?
   #Leaving this open in case we do.
   #end 
   
   def start
       puts "Welcome to your Friendly Neighborhood Bandcamp Deejay!"
       main_menu
   end 
   
   def main_menu
       puts "\nHow do you want to find new music today?"
       puts "\nType 'album' to find music based on an album you like."
       puts "Type 'genre' to find music based on a genre."
       puts "\nType 'roster' to see the artists you have saved."
       #New option! Brings up the list of saved artist objects
       puts "Type 'exit' or 'quit' to quit."
       #In a better or less time-crunched world I'd be able to cross-reference different websites
       #And offer options based on sound or recording studio or label or whatever
       #But for now this is simple and will do
       
       input = gets.strip.downcase
   
       case input
           when "album"
               sleep 1
               puts "\nYou have chosen to find music based on an album you like."
               album
               #Including some sleeps to create a more human rhythm.
           when "genre"
               sleep 1
               puts "\nYou have chosen to find music based on a genre."
               genre
           when "roster"
               #New option! Presents a list of saved artist names
               sleep 1
               if Artist.all.empty?
                #This needs a sleep
                puts "\nI'm sorry, you have no saved artists at this time."
                main_menu
               else 
                roster
               end 
               sleep 1
               main_menu
               #Give it a day to stop screaming and you can add in an option
               #To look up the artist's page on bandcamp
               #Select albums to listen to? Something? Pull up the artist's page?
               #IDEK but there's more options here.
               #Even more if you learn how to add a URL not found thing
           when "exit"
               sleep 1 
               puts "\nThank you! Goodbye!"
           when "quit"
               sleep 1
               puts "\nThank you! Goodbye!"
           else 
               puts "\nI'm sorry, I didn't understand that"
               sleep 2
               main_menu
               #Loop around to the top of the main menu after a moment's pause
       end     
   end 
   
   def album
       puts "\nPlease enter the name of an album you like:"
       album = gets.strip.downcase.gsub(" ", "-")
       puts "\nPlease enter the artist:"
       artist = gets.strip.downcase.gsub(" ", "")
       #Takes artist and album input
       #Reformatting the input to match an album URL
       
       #sleep 3
       #Simulate scraping time, take out this sleep
   
       url = "https://#{artist}.bandcamp.com/album/#{album}"
       #There has to be a way to check if this URL is legit or not

       album_tags = Scraper.scrape_album(url)
       #i.e. the array of the tags scraped from the URL assembled from the user entry
  
       puts "\nHere is a list of genre tags belonging to this album:"

       album_tags.each.with_index(1) do |genre, idx|
           puts "#{idx}. #{genre}"
       end 
       #Genre tags appearing on the album page; I believe these are artist selected
   
       puts "\n Please select a genre by number:"
       input = gets.strip.to_i
       genre = album_tags[input - 1]
       genre_by_album(genre)
       #User chooses a tag and we move to the next method, carrying the genre as the argument
   end 
   
   def genre_by_album(genre)
       puts "\n Here are some other artists in the #{genre} category:" 
       #Reformat the genre tag AFTER you put this dialogue
   
       artists = Scraper.scrape_tag(genre)
       artists.pop
       artists.each.with_index(1) do |artist, idx|
       puts "#{idx}. #{artist}"
       end
       save_artist(artists)
       #Prompt user for an artist to save
       #Then prompt user to save another artist or go back to start
       #Must be a method to look at saved artists/an all method (INCLUDED)
   end 
   
   def genre
       puts "\nPlease select a genre (a description will be provided after you select): Electronic, Metal, Rock, Alternative, Hip-Hop, Experimental, Punk, Pop, Ambient"
       input = gets.strip.downcase
        #Okay, normally I wouldn't put in the descriptions since Rock, Metal, Blues, Jazz, Country, etc etc
        #are pretty well known categories; Bandcamp has Rock, Metal, Hip-Hop, and a pile of weird categories
        #so we're going to do definitions from them and add a step. Be fancy. 

       case input
           when "electronic"
               puts "Electronic music is music that employs electronic and digital musical instruments, circuitry-based musical technology. The generally accepted view of what qualifies as an electronic instrument, as opposed to an instrument that employs electronic assistance or aimplification, has changed over the years. Today's electronic music employs polyphonic synthesizers, digital mixers, and many tools ranging from commercial music software to experimental circuit-based technology. Electronic music includes the sub-categories of techno, dance, house, and bass'n'drum."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               #A definition
               confirm(input)
               #Confirmation dialogue tree, plus calling the scraper 
               back_to_start
               #And back to start with a "do you want to search again"
           when "metal"
               puts "\nMetal, or Heavy Metal, is a sub-genre of rock music that arose in the late 60s and early 70s as a development of gains in amplification and instrument technology. It is characterized by extended guitar solos, precise and intense percussion, and harsh vocals at high volume. (And, at a certain point in its progression, lots of hair.) Current metal sub-genres now include goth or doom metal, grindcore, and progressive metal."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
                confirm(input)
               back_to_start
           when "rock"
               puts "\nRock music grew out of blues, jazz, and country influences in the 1940s and 1950s, particularly in English-speaking countries, and is characterized by a verse-chorus based lyric style and usually a 4/4 beat. Rock music has since branched off into many, many sub-genres but remains a staple of the 20th century cultural history. Rock music tends to include little electronic influence beyond amplification and the occasional syntehsizer and typically involves electric guitar, bass guitar, drums, and vocals as its core sound. Rock sub-genres include pop, progressive rock, what has become known as classic rock (60s-early 90s), and punk rock."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           when "alternative"
               puts "\nAlternative is difficult to characterize as a genre, except in relation to other genres. Alternative grew out of the rock movement from the 70s to the 90s, providing a catch-all label for musicians and bands who branched out into other lyric forms or instrumentation. For these purposes alternative is a broad category for music adhering to no specific style criteria: goth, industrial, and indie rock are all examples of alternative music."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           when "hip-hop"
               puts "\nHip-Hop, or Rap music, was originally characterized by four elements: rapping or emceeing, DJing i.e. using record turntables and mixers to make music, the movement style known as breakdancing involving gymnastic and rhythmic dance, and graffiti signatures. It began as a form of cultural expression for urban communities and continues today in a distinctive lyric style involving rhythmic wordplay and building off of earlier works, including the practice of sampling." 
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           when "experimental"
               puts "\nThe experimental category goes a step further than the alternative category, with no original musical style and encompassing a variety of arrangements of instrumentation, vocal stylings, and other forms of sound not traditionally regarded as music. Sub-categories include noise, drone, avant-garde, and sound art."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input) 
               back_to_start
           when "punk"
               puts "\nPunk as music form developed out of the overlapping fields of the punk movement and rock music. Punk contains the same core instrumentation and lyric style as rock music, but often with a political, anti-establishment element. As part of the anti-establishment ethos punk music tends to be produced through independent labels and independent studios rather than large corporations and conglomerates. This, by necessity, pushes punk artists to be innovative and resourceful, creating often unconventional sounds. Common punk sub-genres include emo, folk punk, ska, and garage."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           when "pop"
               puts "\nPop, although short for popular music, does not necessarily describe the popular music at any given time. It has come to describe a kind of music that employs a faster tempo than the standard rock 4/4, repeated chorus, and a vocal hook or distinctive riff. Pop music is designed to be highly commercial and marketable, and to capture a mood of the time. Therefore pop music also tends to be easily identifiable and commonly linked with a specific decade or year. Pop music includes the sub-genres synth pop, new wave, and country or culture-based sub-genres such as J(apanese)-Pop or K(orean)-Pop."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           when "ambient"
               puts "\nAmbient music prioritizes tone and sound over rhythm or structure, and tends to be instrumental in form. The intent of ambient music is often to express a mood or emotion, or to evoke a common moment or environment such as rain from the inside of a house or a coastal cliff. As with several other genres ambient music developed from the rapid advancements in computerization and electronics, enabling artists to create less instrument-based sounds. Ambient sub-genres are described in such terms as chill-out, atmospheric, dark-ambient, and idm."
               puts "\nIs this the genre you wish to browse in? (Y/N):"
               confirm(input)
               back_to_start
           else
               puts "I'm sorry, I didn't understand that."
               genre
       end 
   
   end 
   
   def back_to_start
       #The Back to Start method! Pretty self explanatory. 
       puts "\n Would you like to see the main menu again? (Y/N)"
       input = gets.strip.upcase
           if input == "Y"
               main_menu
           elsif input == "N"
               puts "\nThank you! Goodbye!"
           else 
               puts "I'm sorry, I didn't understand that."
               back_to_start
           end 
   end 
       
   def confirm(input)
        #Confirmation dialogue tree
        #Gets the input, formats it for the if statement
        #Carries over the input variable from the main genre method
        #Scrapes according to the genre tag and puts out a list of artists
        #If this is not the genre the person wants to search in, starts over.
        confirm = gets.strip.upcase
        if confirm == "Y"
            puts "\nHere are some artists in the #{input} category."
            artists = Scraper.scrape_tag(input)
            artists.pop
            artists.each.with_index(1) do |artist, idx|
            puts "#{idx}. #{artist}"
            end
            save_artist(artists)
            #Again, prompting user to save an artist object
        elsif confirm == "N"
            genre
        else 
            puts "I'm sorry, I didn't understand that."
            sleep 1
            genre
        end 
    end 

    def save_artist(artists)
        puts "\nPlease select an artist (by number) to save or type 'search' to search again:"
        input = gets.strip.downcase
        #Input should be an integer or the word search
        if input == "search"
            main_menu
            #Pretty self-explanatory
        elsif input.to_i.between?(0, artists.length)
            #If the input is an integer between 0 and the length of the array
            #Should this be 1 and the length of the array?
            Artist.new(artists[input.to_i - 1])
            #Create a new Artist object out of the artist
            puts "Saved #{artists[input.to_i - 1]}." 
            #Lets the user know that the artist has been saved.
        else 
            puts "I'm sorry, I didn't understand that."
            sleep 1
            save_artist(artists)
            #Back to the beginning of the user puts in garbage
        end 
        back_to_start
    end

    def roster
        puts "\nHere are your saved artists: "
            Artist.all.each.with_index(1) do |artist, idx|
                puts "#{idx}. #{artist.name}"
            end 
        #Displays saved artists
        puts "\nSelect an artist to examine their albums or type 'search' to search again."
        input = gets.strip
        if input == "search"
            main_menu
        #Again, pretty self-explanatory
        elsif input.to_i.between?(0, Artist.all.length)
            #User has selected an artist
            artist = Artist.all[input.to_i - 1]
            #Pulls the artist name to feed into the scraper code
            albums = Scraper.scrape_artist(artist) 
            #albums = ["Album 1", "Album 2", "Album 3", "Album 4", "Album 2.0: The Remix"]
            #Sample array of albums for debugging purposes
            sleep 1
            puts "\n#{artist.name}'s albums listed on Bandcamp include:"
            albums.each.with_index(1) do |album, idx|
                puts "#{idx}. #{album}"
            end 
            puts "\nSelect an album to save"
            save_album(albums)
            #Scraper.scrape_artist(artist)
            #Scrape the albums from the artist page
        else 
            puts "I'm sorry, I didn't understand that."
            sleep 1
            roster
        end 
    end 

    def save_album(albums)
        number = gets.strip
        #This input is the album number
        if number.to_i.between?(1, albums.length)
            puts "\nType 'have' if you have this album or 'want' if you want to add this album to your wish list."
            input = gets.strip
            #This input is want/have
            #TOO MANY INPUTS
            if input == "have"
                album = Album.new(albums[number.to_i - 1])
                Album.have(album)
                puts "\nHere is your updated collection of albums."
                Album.collection.each.with_index(1) do |album, idx|
                    puts "#{idx}. #{album.name}"
                end 
            elsif input == "want"
                album = Album.new(albums[number.to_i -1])
                Album.want(album)
                puts "\nHere is your updated wish list."
                Album.wish_list.each.with_index(1) do |album, idx|
                    puts "#{idx}. #{album.name}"
                end 
            else 
                puts "\nI'm sorry, I didn't understand that."
                sleep 1
                save_album(albums)
            end 
        else
            puts "I'm sorry, I didn't understand that."
            sleep 1
            save_album(albums)
        end 
        sleep 2
        back_to_start
    end 
  end 
end 



