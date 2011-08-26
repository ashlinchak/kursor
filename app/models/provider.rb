class Provider < ActiveRecord::Base
  belongs_to :category

  def to_param
    permalink
  end
end
