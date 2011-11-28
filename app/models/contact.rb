class Contact < ActiveRecord::Base
  belongs_to :provider
  belongs_to :contact_type

  scope :by_type, order(:contact_type_id)

  CONTACT_TYPES = %w(phone email url skype msn icq)
end
