class Adv::Posting < ActiveRecord::Base

  self.table_name = 'adv_postings'

  attr_accessible :title, :adv_category_id, :posting_type_id, :owner_type_id, :body, :location_id, :contact_person, :email, :price

  belongs_to :user

  belongs_to :category, :class_name => 'Adv::Category', :counter_cache => :postings_count

  POSTING_TYPES = %w( supply demand )

  OWNER_TYPES = %w( private corporate )

  def published?
    published_at.past?
  end

  scope :supply, where(:posting_type_id => POSTING_TYPES.index('supply'))
  scope :demand, where(:posting_type_id => POSTING_TYPES.index('demand'))

  scope :private, where(:owner_type_id => OWNER_TYPES.index('private'))
  scope :corporate, where(:owner_type_id => OWNER_TYPES.index('corporate'))

  scope :published, where("published_at <> ''")

  def supply?
    POSTING_TYPES[posting_type_id] == 'supply'
  end

  def demand?
    POSTING_TYPES[posting_type_id] == 'demand'
  end

  def private?
    OWNER_TYPES[posting_type_id] == 'private'
  end

  def corporate?
    OWNER_TYPES[posting_type_id] == 'corporate'
  end

  def type
    POSTING_TYPES[self.posting_type_id]
  end

  def owner
    OWNER_TYPES[self.posting_type_id]
  end

end
