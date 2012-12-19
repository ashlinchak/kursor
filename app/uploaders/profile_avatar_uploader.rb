# encoding: utf-8

class ProfileAvatarUploader < CarrierWave::Uploader::Base

  #after :store, :delete_original_file

  #def delete_original_file(new_file)
  #  File.delete path if version_name.blank?
  #end

  include CarrierWave::MiniMagick
  #include CarrierWave::RMagick

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
    "" + [version_name, "default_avatar.png"].compact.join('_')
  end

  version :large do
    resize_to_limit(600,600)
  end

  version :medium do
    process :crop
    resize_to_fill(180, 260)
  end

  version :thumb do
    process :crop
    resize_to_fill(64, 64)
  end

  version :icon do
    process :crop
    resize_to_fill(32, 32)
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop "#{w}x#{h}+#{x}+#{y}"
        img
      end
    end
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  #def filename
     #"#{secure_token(10)}.#{file.extension}" if original_filename.present?
  #end

  #protected

  #def secure_token(length=16)
    #var = :"@#{mounted_as}_secure_token"
    #model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  #end

end
