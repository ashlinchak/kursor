class EventCategory < ActiveRecord::Base

  belongs_to :parent, :class_name => 'EventCategory'

  has_many :children, :class_name => 'EventCategory', :foreign_key => 'parent_id', :dependent => :destroy

  has_many :event_categorizings, :dependent => :destroy

  has_many :events, :through => :event_categorizings

  has_many :sub_events, :through => :event_categorizings, :source => :event

  validates_presence_of :name, :description, :permalink
  validates :name, :permalink, :uniqueness => true

  validates_format_of :permalink, :with => /^[a-z\d\-]*$/, :message => "a-z, 0-9 \' - \' ONLY"

  scope :roots, where(:parent_id => nil)

  before_save :generate_permalink

  default_scope order('position ASC')

  def to_param
    permalink
  end

  def to_s
    name
  end

  def generate_permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize if permalink.blank?
    #end
  end

end
