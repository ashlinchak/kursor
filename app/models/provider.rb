class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :categorizings, :dependent => :destroy
  has_many :categories, :through => :categorizings

  before_save :generate_permalink

  mount_uploader :logo, ProviderLogoUploader

  def to_param
    permalink
  end

  def to_s
    name
  end

  def category_ids=(ids)
    self.categories = Category.find(ids)
  end

  def generate_permalink
    unless permalink
      self.permalink = self.name.gsub(/[ \"]/, '-')
    end
  end
end
