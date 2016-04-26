FlickrWall makes a nice collage grid with keyword-related photos on Flickr

tested with ruby 2.2.2

installation:


install ImageMagick on your system

gem install rmagick
gem install nokogiri

Install the gem:
gem install flickrwall-0.0.1.gem


usage:

require 'flickrwall'

api_key = "12345678901234"
dictfile = "/usr/share/dict/cracklib-small"
filename = "test.jpg"
list = [
  "Fernsehturm",
  "Bach",
  "Elvis",
  "Mozart",
  "Flowers",
  "Horse",
  "Dolphin",
]

FlickrWall.flickr_wall(list,dictfile,filename,api_key)