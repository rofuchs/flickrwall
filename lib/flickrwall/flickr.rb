# encoding: utf-8
# module FlickrWall
module FlickrWall
  
  def self.get_flickr_image(keyword, api_key)
    uri = URI('https://api.flickr.com/services/rest/')
    uri.query = URI.encode_www_form(request_params(api_key,keyword))
    res = Net::HTTP.get_response(uri)
    result = res.body if res.is_a?(Net::HTTPSuccess)

    return [] if Nokogiri::XML(result).xpath('rsp/photos')[0]['pages'] == '0'
    photo = Nokogiri::XML(result).xpath('rsp/photos/photo').first
    pho_id = photo['id']
    server = photo['server']
    farm = photo['farm']
    originalsecret = photo['originalsecret']
    originalformat = photo['originalformat']
    secret = photo['secret']

    if originalsecret
      photo_source = "https://farm#{farm}.staticflickr.com/#{server}/#{pho_id}_#{originalsecret}_o.#{originalformat}"
    else
      photo_source = "https://farm#{farm}.staticflickr.com/#{server}/#{pho_id}_#{secret}.jpg"
    end
    puts photo_source # debug
    Magick::Image.from_blob(open(photo_source).read).first
  end

  def self.get_flickr_images(wordlist, randomwordlist, api_key)
    image_list = Magick::ImageList.new
    image = []
    i = 0

    wordlist.each do |keyword|
      image = get_flickr_image(keyword, api_key)
      while image == []
        image = get_flickr_image(randomwordlist[i], api_key)
        i += 1
      end
      image_list << image
    end

    # fill with random images
    while image_list.size < 10
      image = get_flickr_image(randomwordlist[i], api_key)
      while image == []
        image = get_flickr_image(randomwordlist[i], api_key)
        i += 1
      end
      image_list << image
      i += 1
    end

    image_list
  end

  def self.request_params(api_key, keyword)
    params = {
      method: 'flickr.photos.search',
      api_key: api_key,
      text: keyword,
      tags: keyword,
      extras: 'original_format',
      sort: 'interestingness-desc',
      per_page: 1
    }
    return params
  end

  private_class_method :get_flickr_image, :get_flickr_images
end
