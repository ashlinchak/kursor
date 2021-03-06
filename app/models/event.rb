class Event < ActiveRecord::Base

  require 'nokogiri'
  require 'open-uri'

  attr_accessible :description, :end_datetime, :eventable_id, :eventable_type, :location_id, :min_price, :max_price, :start_datetime, :title, :location_attributes, :event_category_ids, :provider_name, :teacher

  attr_accessor :provider_name

  after_initialize :build_nested_resources

  before_save :check_enddatetime, :add_nofollow

  belongs_to :eventable, :polymorphic => true

  has_many :event_categorizings, :dependent => :destroy
  has_many :event_categories, :through => :event_categorizings

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  validates_presence_of :start_datetime, :title, :description

  default_scope order('start_datetime ASC')

  paginates_per 30

  scope :upcoming, where('end_datetime > ?', DateTime.now)

  scope :ended, where('end_datetime < ?', DateTime.now)

  def event_category_ids=(ids)
    self.event_categories = EventCategory.find(ids)
  end

  def build_nested_resources
    self.build_location unless location
  end

  def check_enddatetime
    if self.end_datetime.blank?
      self.end_datetime = self.start_datetime
    end
  end

  def add_nofollow
    doc = Nokogiri::HTML.parse(self.description)
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
      self.description = self.description.gsub(href1, href1+' rel="nofollow" target="_blank"')
      self.description = self.description.gsub(href2, href2+' rel="nofollow" target="_blank"')
    end
  end

  def provider_name= name
    if provider = Provider.find_by_name(name)
      #p "provider: #{provider}"
      self.eventable = provider
    end
  end

  # for calendar
  def start_time
    start_datetime
  end

  define_index do
    indexes :title
    indexes :description
    set_property :field_weights => { :title => 10, :description => 6 }
    set_property :enable_star => 1
    set_property :min_infix_len => 3
    set_property :html_strip => 1
  end

end
