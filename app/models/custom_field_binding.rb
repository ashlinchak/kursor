class CustomFieldBinding < ActiveRecord::Base
  belongs_to :custom_field
  belongs_to :provider

  #default_scope order('position ASC, created_at DESC')

  def name
    custom_field.name
  end

  def position
    custom_field.position
  end

end
