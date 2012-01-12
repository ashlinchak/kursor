class Image < ActiveRecord::Base
  belongs_to :imageable

  mount_uploader :src, ImageUploader
end
