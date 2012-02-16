class PostingCategorizing < ActiveRecord::Base
  belongs_to :posting
  belongs_to :posting_category

  def to_s
    posting_category
  end
end
