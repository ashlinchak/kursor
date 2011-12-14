class CustomFlagBinding < ActiveRecord::Base
  belongs_to :custom_flag
  belongs_to :provider
end
