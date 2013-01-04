class Posting < ActiveRecord::Base

  include ::Taggable

  require 'nokogiri'
  require 'open-uri'

  before_save :add_nofollow

  attr_accessor :image_attributes

  belongs_to :user

  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => lambda { |i| i[:src].blank? }

  #validates :images, :length => { :maximum => 1}



  validates_presence_of :title, :excerpt, :body#, :images

  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags,     :through => :taggings

  has_many :posting_categorizings, :dependent => :destroy
  has_many :posting_categories, :through => :posting_categorizings

  has_one :metatag, :as => :metatagable, :dependent => :destroy
  accepts_nested_attributes_for :metatag, :reject_if => proc { |attr| attr[:title].blank? && attr[:description].blank? && attr[:keywords].blank? && attr[:additional].blank?  }

  POSTING_TYPES = %w( text video )

  default_scope order('published_at desc')

  scope :recent, lambda { where('created_at >= ?', Time.now - 32.weeks).limit(4) }

  scope :approved, where(:is_approved => true)

  scope :published, lambda { where('published_at <= ?', Time.now) }
  scope :not_published, lambda { where('published_at > ?', Time.now) }

  scope :text_postings, where(:posting_type_id => POSTING_TYPES.index('text'))
  scope :video_postings, where(:posting_type_id => POSTING_TYPES.index('video'))

  def published?
    published_at.past?
  end

  def posting_category_ids=(ids)
    self.posting_categories = PostingCategory.find(ids)
  end

  def text_posting?
    POSTING_TYPES[posting_type_id] == 'text'
  end

  def video_posting?
    POSTING_TYPES[posting_type_id] == 'video'
  end

  def to_s
    title
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def approve!
    self.is_approved = true
    if self.published_at == self.created_at
      self.published_at = Time.now
    end
    save
  end

  def decline!
    self.is_approved = false
    save
  end

  def add_nofollow
    doc = Nokogiri::HTML.parse(self.body)
    links = []
    doc.css('a').each do |link|
      next unless link['rel'].blank?
      next if (link['href'][0,4] != 'http' && link['href'][0,3] != 'www')
      next if (link['href'].downcase.include?('kursor.org.ua'))
      links << link
    end

    links.uniq.each do |link|
      link['rel'] = 'nofollow'
      link['target'] = '_blank'
      href1 = "href='#{link['href']}'"
      href2 = 'href="'+link['href']+'"'
      self.body = self.body.gsub(href1, href1+' rel="nofollow" target="_blank"')
      self.body = self.body.gsub(href2, href2+' rel="nofollow" target="_blank"')
    end
  end

  define_index do
    indexes :title
    indexes :excerpt
    indexes :body
    set_property :field_weights => { :title => 10, :excerpt => 6, :body => 3 }
    set_property :enable_star => 1
    set_property :min_infix_len => 3
  end

end
