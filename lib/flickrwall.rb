# encoding: utf-8
require 'net/http'
require 'rubygems'
require 'rmagick'
require 'nokogiri'
require 'open-uri'

require_relative './flickrwall/random_words.rb'
require_relative './flickrwall/flickr.rb'
require_relative './flickrwall/montage.rb'

# module FlickrWall
module FlickrWall
  module_function

  def self.flickr_wall(wordlist, dictfile, filename, api_key)
    randomwordlist = get_random_words(dictfile, 30)
    image_list = get_flickr_images(wordlist, randomwordlist, api_key)
    crop_images(image_list)
    write_montage(image_list, filename)
  end
end
