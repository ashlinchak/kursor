class User < ActiveRecord::Base



  # :token_authenticatable
  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable, :async

  #include Devise::Async::Model # should be below call to `devise`

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :postings_count, :password_confirmation, :remember_me, :account_type_id, :providers, :uid,
                  :confirmed_at, :confirmation_token, :confirmation_sent_at # for rake task users:confirm_all_active

  def password_required?
      super if confirmed?
    end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

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
  has_many :postings, :dependent => :destroy
  has_many :adv_postings, :class_name => 'Adv::Posting', :dependent => :destroy
  has_many :votes

  accepts_nested_attributes_for :providers
  accepts_nested_attributes_for :tutor
  accepts_nested_attributes_for :profile

  # TODO: find proper names for acc types
  ACCOUNT_TYPES = %w( user tutor school )

  paginates_per 50

  scope :online, lambda{ where("updated_at > ?", 30.minutes.ago) }

  def online?
    updated_at > 30.minutes.ago
  end

  def to_s
    if visitor? && profile
      if profile.full_name && !profile.full_name.blank?
        profile.full_name
      else
        email.split(/@/)[0]
      end
    elsif tutor?
      if tutor.name && !tutor.name.blank?
        tutor.name
      else
        email.split(/@/)[0]
        end
    else
      email.split(/@/)[0]
    end
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
    if self.visitor?
      I18n.t(:'activerecord.attributes.user.account_types.visitor')
    elsif self.tutor?
      I18n.t(:'activerecord.attributes.user.account_types.tutor')
    elsif self.school?
      I18n.t(:'activerecord.attributes.user.account_types.school')
    end
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
