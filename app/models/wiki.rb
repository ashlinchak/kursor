class Wiki < ActiveRecord::Base

  require 'nokogiri'
  require 'open-uri'

  before_save :add_nofollow

  belongs_to :parent, :class_name => 'Wiki'

  has_many :children, :class_name => 'Wiki', :foreign_key => 'parent_id', :dependent => :destroy

  validates :title, :permalink, :presence => true

  validates :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  mount_uploader :image, WikiImageUploader

  def has_children?
    self.children.size > 0
  end

  def root?
    parent_id.nil?
  end

  def to_param
    permalink
  end

  def to_s
    title
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

end
