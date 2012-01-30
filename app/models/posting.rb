class Posting < ActiveRecord::Base
  include ::Taggable

  attr_accessor :image_attributes

  belongs_to :user
  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank # lambda { |i| i[:src].blank? }

  has_many :taggings, :as => :taggable
  has_many :tags,     :through => :taggings
  #accepts_nested_attributes_for :tags

  scope :recent, lambda { where('created_at >= ?', Time.now - 1.week).limit(10) }

  def to_s
    title
  end
end
