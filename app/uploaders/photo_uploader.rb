# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{get_last_dir_part(model.id)}"
  end

  def get_last_dir_part(modelid)
    p = modelid.to_s.rjust(9, '0')
    "#{p[0,3]}/#{p[3,3]}/#{p[6,3]}"
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  def default_url
    "/assets/" + [version_name, "default_room.png"].compact.join('_')
  end

  version :large do
    process :resize_to_fit => [633, 472]
  end

  version :small, :from_version => :thumb  do
    process :resize_to_fill => [115, 75]
  end

  version :thumb, :from_version => :large  do
    process :resize_to_fill => [210, 115]
  end

  version :icon , :from_version => :small do
    process :resize_to_fill => [60, 44]
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png bmp)
  end

  def watermark(path_to_file)
    manipulate! do |img|
      logo = MiniMagick::Image.read(path_to_file).first
      img  = img.composite(logo, MiniMagick::SouthEastGravity, MiniMagick::OverCompositeOp)
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  def filename
    model && model.read_attribute(:photo).present? ? model.read_attribute(:photo) : "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

end
