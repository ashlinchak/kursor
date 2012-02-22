class PostingCategory < ActiveRecord::Base

  has_many :posting_categorizings, :dependent => :destroy

  has_many :postings, :through => :posting_categorizings

  validates_presence_of :name, :description #:permalink

  def to_s
    name
  end


end
