# encoding: utf-8

class TutorCategoryIconUploader < CarrierWave::Uploader::Base


  after :store, :delete_original_file

  def delete_original_file(new_file)
    File.delete path if version_name.blank?
  end

  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "" + [version_name, "default_cat_icon.png"].compact.join('_')
  end

  version :standart do
    process :png
    resize_to_fill(64,64)
  end

  version :small do
    process :png
    resize_to_fill(32,32)
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  def png
    manipulate! do |img|
      img.format("png")
      img
    end
  end

end
