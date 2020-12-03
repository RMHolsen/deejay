#Each class should have its own file
#Yes even when there are small classes

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
    @@collection = []
    @@wish_list = []

    def initialize(name)
        @name = name
    end 

    def self.want(name)
        @@wish_list << name
    end 

    def self.have(name)
        @@collection << name
    end 

    def self.collection
        @@collection
    end 

    def self.wish_list
        @@wish_list
    end 
end 

