class Categorizing < ActiveRecord::Base
  belongs_to :category, :counter_cache => true
  belongs_to :provider

  def to_s
    category
  end
end
