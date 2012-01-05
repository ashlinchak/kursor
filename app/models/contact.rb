class Contact < ActiveRecord::Base

  belongs_to :contactable, :polymorphic => true

  scope :by_type, order(:contact_type_id)

  CONTACT_TYPES = %w(phone email url skype msn icq)

  def contact_type
    CONTACT_TYPES[contact_type_id]
  end
end
