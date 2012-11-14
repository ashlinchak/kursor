class User < ActiveRecord::Base

  # :token_authenticatable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  include Devise::Async::Model # should be below call to `devise`

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_type_id, :providers, :uid,
                  :confirmed_at, :confirmation_token, :confirmation_sent_at # for rake task users:confirm_all_active

  attr_accessor :providers_attributes, :profile_attributes

  #before_validation :generate_password, :on => :create

  has_many :authentications, :dependent => :destroy
  has_one :administrator, :dependent => :destroy
  has_many :providers, :dependent => :destroy
  has_one :tutor, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :students
  has_many :schools, :through => :students
  has_many :schedule_events
  has_many :postings
  has_many :votes

  accepts_nested_attributes_for :providers
  accepts_nested_attributes_for :tutor
  accepts_nested_attributes_for :profile

  # TODO: find proper names for acc types
  ACCOUNT_TYPES = %w( user tutor school )

  paginates_per 50

  def to_s
    email
    #if visitor? && profile
    #  if profile.full_name && !profile.full_name.blank?
    #    profile.full_name
    #  else
    #    email.split(/@/)[0]
    #  end
    #elsif tutor? || school?
    #  if provider
    #    provider.name
    #  else
    #    email.split(/@/)[0]
    #  end
    #else
    #  email.split(/@/)[0]
    #end
  end

  # overriding default json fields
  def as_json options ={}
    super(:only => [:email])
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

  def can_add_provider?
    self.providers.count < 1
    #if account.free?
    #  providers.count < 1
    #elsif account.standard?
    #  providers.count < 5
    #end
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)

    user = User.where(:email => auth.info["email"]).first

    unless user
      user = User.create(email: auth.info["email"],
                         password: Devise.friendly_token[0,20],
      )
    end
    user.authentications.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:oauth_provider => auth.provider, :uid => auth.uid).first || User.find_by_email(auth.info.email)
    if user
      if user.oauth_provider.blank? || user.uid.blank?
        user.oauth_provider = auth.provider
        user.uid = auth.uid
        user.save
      end
    else
      user = User.create(email:auth.info.email,
                         password:Devise.friendly_token[0,20]
      )
    end
    user.authentications.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user
  end

  #def self.new_with_session(params, session)
  #  super.tap do |user|
  #    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #      user.email = data["email"] if user.email.blank?
  #    end
  #  end
  #end

end
