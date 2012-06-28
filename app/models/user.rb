class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :provider_attributes, :profile_attributes

  has_one :administrator, :dependent => :destroy
  has_one :provider, :dependent => :destroy
  has_one :tutor, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_one :user_activation, :dependent => :destroy
  has_many :students
  has_many :schools, :through => :students
  has_many :schedule_events
  has_many :postings

  has_many :votes

  before_save :encrypt_password
  after_create :generate_activation

  validates_presence_of     :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of   :email
  validates_uniqueness_of :email

  accepts_nested_attributes_for :provider
  accepts_nested_attributes_for :tutor
  accepts_nested_attributes_for :profile

  # TODO: find proper names for acc types
  ACCOUNT_TYPES = %w( user tutor school )

  paginates_per 50

  def to_s
    if visitor? && profile
      if profile.full_name && !profile.full_name.blank?
        profile.full_name
      else
        email.split(/@/)[0]
      end
    elsif tutor? || school?
      if provider
        provider.name
      else
        email.split(/@/)[0]
      end
    else
      email.split(/@/)[0]
    end
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

  def visitor?
    ACCOUNT_TYPES[account_type_id] == 'user'
  end

  def tutor?
    ACCOUNT_TYPES[account_type_id] == 'tutor'
  end

  def school?
    ACCOUNT_TYPES[account_type_id] == 'school'
  end

  def generate_activation
    self.create_user_activation
  end

end
