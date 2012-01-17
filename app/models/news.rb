class News < ActiveRecord::Base
  attr_accessor :image_attributes

  #belongs_to :user
  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => lambda { |i| i[:src].blank? }
end
