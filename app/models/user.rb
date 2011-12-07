class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :provider_attributes

  has_one :administrator, :dependent => :destroy
  has_one :provider, :dependent => :destroy
  has_one :user_activation, :dependent => :destroy

  before_save :encrypt_password
  after_create :generate_activation

  validates_presence_of     :password, :password_confirmation, :on => :create
  validates_confirmation_of :password
  validates_presence_of   :email
  validates_uniqueness_of :email

  accepts_nested_attributes_for :provider

  default_scope order('created_at DESC')

  paginates_per 50

  def to_s
    email
  end

  # overriding default json fields
  def as_json options ={}
    super(:only => [:email, :is_active])
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def administrator?
    !!administrator
  end

  def generate_activation
    self.create_user_activation
  end


end
