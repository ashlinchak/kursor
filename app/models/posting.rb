class Posting < ActiveRecord::Base

  include ::Taggable

  require 'nokogiri'
  require 'open-uri'

  acts_as_commentable

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

  before_save :add_nofollow

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
      self.body = self.body.gsub(href1, href1+' rel="nofollow"')
      self.body = self.body.gsub(href2, href2+' rel="nofollow"')
    end
  end


end
