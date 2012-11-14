class Promotion < ActiveRecord::Base

  belongs_to :promotionable, polymorphic: true
  attr_accessor :provider_name
  attr_accessible :end_date, :is_featured, :is_vip, :start_date, :provider_name
  validates :promotionable_id, presence: true

  scope :by_position, order('position asc')
  scope :vip, where(:is_vip => true)

  def provider_name= name
    if provider = Provider.find_by_name(name).id
      #p "provider: #{provider}"
      self.promotionable = provider
    end
  end
end
