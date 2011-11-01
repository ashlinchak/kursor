class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RedirectBackError,  :with => :render_404
  rescue_from ActionController::RoutingError,       :with => :render_404
  rescue_from ActiveRecord::RecordNotFound,         :with => :render_404

  protected

  def render_404
    #render :file => File.join(Rails.root, 'public/404.html'), :layout => false, :status => 404
    flash[:error] = t(:'site.errors.error_404')
    redirect_to root_url
  end

  private

  def root_categories
    @root_categories = Category.roots
  end
  helper_method :root_categories

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue
    nil
  end
  helper_method :current_user

  def current_user= object
    if object.is_a? User
      session[:user_id] = object.id
      @current_user = object
    else
      @current_user = session[:user_id] = nil
    end
  end
  helper_method :current_user

  def guest
    User.new
  end
  helper_method :guest

  def authenticated?
    !!current_user
  end
  helper_method :authenticated?

  def authorized?
    authenticated? && current_user.administrator?
  end
  helper_method :authorized?

  def require_authentication
    unless authenticated?
      redirect_to login_url, :notice => 'Login required'
    end
  end

  def require_authorization
    unless authorized?
      redirect_to root_url, :notice => 'Admin required'
    end
  end

end
