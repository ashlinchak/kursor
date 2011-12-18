class CustomFlagBinding < ActiveRecord::Base
  belongs_to :custom_flag
  belongs_to :provider

  def name
    custom_flag.name
  end

  def position
    custom_flag.position
  end

end
