class Artist
    @@roster = []
    
    attr_accessor :name

    def initialize(name)
        @name = name
        @@roster << self
    end 

    def self.all
        @@roster
    end 
end 

class Album
    #If possible, this will let a user pull a saved artist
    #And pull maybe their Wiki page? Their home page from a link from Bandcamp?
    #Definitely their album list from Bandcamp
    #And pick an album to save

    attr_accessor :name

    def initialize(name)
        @name = name
    end 
end 