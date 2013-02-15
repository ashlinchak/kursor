class Adv::Category < ActiveRecord::Base

  self.table_name = 'adv_categories'

  has_ancestry

  has_many :postings, :class_name => 'Adv::Posting', :dependent => :destroy

  attr_accessible :name, :permalink, :description, :parent_id, :postings_count

  before_save :generate_adv_cat_permalink

  validates_uniqueness_of :permalink

  default_scope order('position ASC')

  def to_param
    permalink
  end

  def to_s
    name
  end

  def generate_adv_cat_permalink
    self.permalink = Russian.translit(name).parameterize if permalink.blank?
  end

end
