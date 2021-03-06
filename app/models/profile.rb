class Profile < ActiveRecord::Base

  belongs_to :user

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :avatar_secure_token

  has_one :location, :as => :addressable, :class_name => 'Address::Location', :dependent => :destroy
  accepts_nested_attributes_for :location

  has_many :contacts, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :reject_if => lambda { |c| c[:value].blank? || c[:contact_type_id].blank? }, :allow_destroy => true

  validates_presence_of :full_name

  mount_uploader :avatar, ProfileAvatarUploader

  validates :avatar, :file_size => { :maximum => 1.megabytes.to_i }

  after_update :crop_avatar

  def crop_avatar
    if crop_x.present?
      avatar.recreate_versions!
    end
  end

end
