class Categorizing < ActiveRecord::Base
  belongs_to :category, :counter_cache => :providers_count
  belongs_to :provider

  def to_s
    category
  end
end
