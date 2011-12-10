class CustomFieldBinding < ActiveRecord::Base
  belongs_to :custom_field
  belongs_to :provider
end
