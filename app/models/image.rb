require 'file_size_validator'
class Image < ActiveRecord::Base

  belongs_to :imageable

  mount_uploader :src, ImageUploader

  validates :src,:presence => true, :file_size => { :maximum => 1.megabytes.to_i }, :on => :create

end
