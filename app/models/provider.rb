class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :categorizings, :dependent => :destroy
  has_many :categories, :through => :categorizings

  has_one :location, :through => :addressable

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
    self.categories = Category.find(ids)
  end

  def generate_permalink
    #unless permalink
      # make simple util to parametrize/slugify permalink
      self.permalink = Russian.translit(name).parameterize
    #end
  end
end
