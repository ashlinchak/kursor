class Posting < ActiveRecord::Base
  include ::Taggable

  attr_accessor :image_attributes

  belongs_to :user

  #has_one :image, :as => :imageable, :dependent => :destroy
  #accepts_nested_attributes_for :image, :allow_destroy => true, :reject_if => lambda { |i| i[:src].blank? }

  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true #, :reject_if => lambda { |i| i[:src].blank? }

  #validates :images, :length => { :maximum => 1}

  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags,     :through => :taggings

  has_many :posting_categorizings, :dependent => :destroy
  has_many :posting_categories, :through => :posting_categorizings

  default_scope order('created_at desc')

  scope :recent, lambda { where('created_at >= ?', Time.now - 32.weeks).limit(4) }

  scope :approved, where(:is_approved => true)

  def posting_category_ids=(ids)
    self.posting_categories = PostingCategory.find(ids)
  end

  def to_s
    title
  end

  def approve!
    self.is_approved = true
    save
  end

  def decline!
    self.is_approved = false
    save
  end
end
