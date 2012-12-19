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
  accepts_nested_attributes_for :contacts, :reject_if => lambda { |c| c[:value].blank? || c[:contact_type_id].blank? }, :allow_destroy => true

  has_one :promotion, :as => :promotionable, :dependent => :destroy
  accepts_nested_attributes_for :promotion

  has_many :events, :as => :eventable, :dependent => :destroy
  accepts_nested_attributes_for :events, :allow_destroy => true

  has_many :custom_field_bindings, :dependent => :destroy
  has_many :custom_fields, :through => :custom_field_bindings
  accepts_nested_attributes_for :custom_field_bindings, :reject_if => lambda { |b| b[:value].blank? }, :allow_destroy => true

  has_many :custom_flag_bindings, :dependent => :destroy
  has_many :custom_flags, :through => :custom_flag_bindings
  accepts_nested_attributes_for :custom_flag_bindings, :reject_if => lambda { |b| b[:value].blank? }, :allow_destroy => true

  has_many :students
  has_many :student_users, :through => :students, :source => :user

  has_many :votes, :as => :voteable, :dependent => :destroy

  has_one :rating, :as => :rateable, :dependent => :destroy

  before_save :generate_permalink

  mount_uploader :logo, ProviderLogoUploader

  validates :logo, :file_size => { :maximum => 1.megabytes.to_i }

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

  def destroy_filials!
    self.filials.destroy_all
  end

  def category_ids=(ids)
    self.categories = Category.find(ids)
  end

  def generate_permalink
    #unless permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize
    #end
  end

  define_index do
    indexes :name, sortable: true
    set_property :star => 1
    set_property :min_infix_len => 3
  end

end