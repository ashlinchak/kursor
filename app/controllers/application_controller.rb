class ApplicationController < ActionController::Base

  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers

  before_filter :set_adv_name

  #unless  Rails.env.development?
  #  rescue_from ActionController::RedirectBackError,  :with => :render_500
  #  rescue_from ActionController::RoutingError,       :with => :render_404
  #  rescue_from ActiveRecord::RecordNotFound,         :with => :render_404
  #end

  protected

  def render_404
    flash[:error] = t(:'site.errors.error_404')
    redirect_to root_url
  end

  def render_500
    flash[:error] = t(:'site.errors.error_500')
    redirect_to root_url
  end

  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
  end

  def ckeditor_before_create_asset(asset)
    asset.assetable = current_user
    return true
  end

  private

  def root_categories
    @root_categories ||= Category.roots
  end
  helper_method :root_categories

  def root_tutor_categories
    @root_tutor_categories ||= TutorCategory.roots
  end
  helper_method :root_tutor_categories

  def root_event_categories
      @root_event_categories ||= EventCategory.roots
  end
  helper_method :root_event_categories

  def root_posting_categories
    @root_posting_categories ||= PostingCategory.roots
  end
  helper_method :root_posting_categories

  def regions
    @regions ||= Address::Region.all
  end
  helper_method :regions

  def recent_postings
    @recent_postings ||= Posting.approved.recent
  end
  helper_method :recent_postings

  def guest
    @guest ||= User.new
  end
  helper_method :guest

  def authenticated?
    user_signed_in?
  end
  helper_method :authenticated?

  def authorized?
    user_signed_in? && current_user.administrator?
  end
  helper_method :authorized?

  def require_authorization
    unless authorized?
      flash[:error] = 'Admin required'
      redirect_to root_url
    end
  end

  def after_sign_in_path_for(resource) # Redirect to user path after signing in
    user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope) # Keeping user on the same page after signing out
      home_path
      #request.referrer
  end



  def set_adv_name
    @adv_group_name = controller_name.singularize[0..9]
    @adv_sub_name = if action_name == 'index'
                      'root'
                    elsif defined? category
                      category.permalink
                    elsif defined? tutor_category
                      tutor_category.permalink
                    elsif defined? posting_category
                      posting_category.permalink
                    elsif defined? event_category
                      event_category.permalink
                    else
                      'default'
                    end
  end
end