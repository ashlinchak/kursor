class Categorizing < ActiveRecord::Base
  belongs_to :tutor_category, :counter_cache => :tutors_count
  belongs_to :tutor


  def to_s
    tutor_category
  end
end
