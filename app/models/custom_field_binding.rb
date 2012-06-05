class CustomFieldBinding < ActiveRecord::Base
  belongs_to :custom_field
  belongs_to :provider

  def name
    custom_field.name
  end

  def position
    custom_field.position
  end

end
