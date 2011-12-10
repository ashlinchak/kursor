class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :categorizings, :dependent => :destroy
  has_many :categories, :through => :categorizings

  has_many :filials, :dependent => :destroy
  accepts_nested_attributes_for :filials, :reject_if => :all_blank, :allow_destroy => true

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  has_many :contacts, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :allow_destroy => true

  has_many :custom_field_bindings, :dependent => :destroy
  has_many :custom_fields, :through => :custom_field_bindings
  accepts_nested_attributes_for :custom_field_bindings, :reject_if => lambda { |b| b[:value].blank? }

  before_save :generate_permalink

  mount_uploader :logo, ProviderLogoUploader

  scope :approved, where( :is_approved => true )

  def to_param
    "#{id}-#{permalink}"
    #"#{permalink}"
  end

  def to_s
    name
  end

  def category_ids=(ids)
    self.categories = Category.find(ids)# || []
  end

  def generate_permalink
    #unless permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize
    #end
  end
end
