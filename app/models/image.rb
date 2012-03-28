require 'file_size_validator'
class Image < ActiveRecord::Base
  belongs_to :imageable

  mount_uploader :src, ImageUploader

  validates :src,
    :presence => true,
    :file_size => {
      :maximum => 3.megabytes.to_i
    }

end


#class Image < ActiveRecord::Base
#  belongs_to :imageable
#
#  mount_uploader :src, ImageUploader
#end
