class UserActivation < ActiveRecord::Base
  belongs_to :user

  before_create :generate_token

  def to_s
    self.token
  end

  def to_param
    self.token
  end

  def generate_token
    self.expire_at = Time.now + 1.week
    self.token = SecureRandom.base64
  end
end
