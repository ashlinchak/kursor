class Tutor < ActiveRecord::Base


  belongs_to :tutor_category
  belongs_to :user

  has_many :tutor_categorizings, :dependent => :destroy
  has_many :tutor_categories, :through => :tutor_categorizings

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  has_many :contacts, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :reject_if => lambda { |c| c[:value].blank? || c[:contact_type_id].blank? }, :allow_destroy => true

  has_many :events, :as => :eventable, :dependent => :destroy
  accepts_nested_attributes_for :events, :allow_destroy => true

  has_many :tutor_custom_field_bindings, :dependent => :destroy
  has_many :tutor_custom_fields, :through => :tutor_custom_field_bindings
  accepts_nested_attributes_for :tutor_custom_field_bindings, :reject_if => lambda { |b| b[:value].blank? }, :allow_destroy => true

  has_many :votes, :as => :voteable, :dependent => :destroy

  has_one :rating, :as => :rateable, :dependent => :destroy

  before_save :generate_permalink

  mount_uploader :avatar, TutorAvatarUploader

  searchable_by :name
  paginates_per 30

  scope :approved, where( :is_approved => true )
  scope :top_rated, order('created_at desc').limit(5)

  def to_param
    "#{id}-#{permalink}"
    #"#{permalink}"
  end

  def to_s
    name
  end

  def approve!
    self.is_approved = true
    save
  end

  def decline!
    self.is_approved = false
    save
  end

  def tutor_category_ids=(ids)
    self.tutor_categories = TutorCategory.find(ids)# || []
  end

  def generate_permalink
    #unless permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize
    #end
  end
end
