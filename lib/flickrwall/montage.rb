# encoding: utf-8
# module FlickrWall
module FlickrWall
  def self.crop_images(image_list)
    image_list.each do |img|
      if img.rows < img.columns
        img.crop!(10, 10, img.rows, img.rows)
      else
        img.crop!(10, 10, img.columns, img.columns)
      end
    end
  end

  def self.write_montage(image_list, filename)
    image2 = image_list.montage do |mont|
      mont.geometry = Magick::Geometry.new(200, 200, 1, 1)
      mont.tile = '5x2'
      mont.border_width = 0
    end
    image2.write filename
  end

  private_class_method :crop_images, :write_montage
end
