class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessor :provider_attributes, :profile_attributes#, :password, :password_confirmation

  has_one :administrator, :dependent => :destroy
  has_one :provider, :dependent => :destroy
  has_one :tutor, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :students
  has_many :schools, :through => :students
  has_many :schedule_events
  has_many :postings

  has_many :votes

  #validates_presence_of     :password, :on => :create
  #validates_confirmation_of :password
  #validates_presence_of   :email
  #validates_uniqueness_of :email

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

  def user_type
    @user_type = ACCOUNT_TYPES[self.account_type_id]
  end

end
