class Categorizing < ActiveRecord::Base
  belongs_to :category
  belongs_to :provider

  def to_s
    category
  end
end
