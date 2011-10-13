class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :categorizings, :dependent => :destroy
  has_many :categories, :through => :categorizings

  before_save :generate_permalink

  def to_param
    permalink
  end

  def to_s
    name
  end

  def category_ids=(ids)
    #categories = self.categories
    #ids.each do |category_id|
      #self.categorizings.build(:category_id => category_id)
    #end
    self.categories = Category.find(ids)
  end

  def generate_permalink
    unless permalink
      self.permalink = self.name.gsub(/[ \"]/, '-')
    end
  end
end
