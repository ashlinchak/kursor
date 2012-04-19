class Provider < ActiveRecord::Base
  belongs_to :tutor_category
  belongs_to :user

  has_many :tutor_categorizings, :dependent => :destroy
  has_many :tutor_categories, :through => :tutor_categorizings

  #has_many :filials, :dependent => :destroy
  #accepts_nested_attributes_for :filials, :reject_if => :all_blank, :allow_destroy => true

  has_one :location, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :location

  has_many :contacts, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :reject_if => lambda { |c| c[:value].blank? || c[:contact_type_id].blank? }, :allow_destroy => true

  has_many :custom_field_bindings, :dependent => :destroy
  has_many :custom_fields, :through => :custom_field_bindings
  accepts_nested_attributes_for :custom_field_bindings, :reject_if => lambda { |b| b[:value].blank? }, :allow_destroy => true

  has_many :custom_flag_bindings, :dependent => :destroy
  has_many :custom_flags, :through => :custom_flag_bindings
  accepts_nested_attributes_for :custom_flag_bindings, :reject_if => lambda { |b| b[:value].blank? }, :allow_destroy => true

  has_many :students
  has_many :student_users, :through => :students, :source => :user

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
