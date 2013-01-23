class Adv::Category < ActiveRecord::Base

  self.table_name = 'adv_categories'

  has_ancestry

  attr_accessible :name, :permalink, :description, :parent_id

  before_save :generate_adv_cat_permalink

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
