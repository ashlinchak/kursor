# encoding: utf-8

class ProviderLogoUploader < CarrierWave::Uploader::Base

  after :store, :delete_original_file

  def delete_original_file(new_file)
    File.delete path if version_name.blank?
  end

  include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "" + [version_name, "default_provider_logo.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  #process :resize_to_fill => [800, 800]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :icon do
    process :resize_to_fill => [32, 32]
  end

  version :thumb do
    process :resize_to_fill => [64, 64]
  end

  version :medium do
    process :resize_to_limit => [220, 220]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  def filename
     "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
