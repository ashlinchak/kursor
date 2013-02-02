class PostingsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :feed]

  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

  def index
  end

  def show
  end

  def new
    posting.images.build
    posting.build_metatag
  end

  def create
    posting.user = current_user
    posting.published_at = Time.now if posting.published_at.blank?
    if posting.save
      unless authorized?
        posting.posting_categories << PostingCategory.find_by_permalink('blog')
      end
      flash[:success] = t(:'postings.create.success')
      NotificationMailer.posting_created(posting).deliver
      redirect_to posting_path(posting)
    else
      render :new
    end
  end

  def edit
    #@posting = current_user.postings.find(params[:posting])
    posting.images.build if posting.new_record?
    posting.build_metatag unless posting.metatag
  end

  def update
    if posting.update_attributes params[:posting]
      flash[:success] = t(:'postings.update.success')
      redirect_to posting_path(posting)
    else
      render :new
    end
  end

  def destroy
    posting.destroy
    redirect_to user_postings_path(current_user)
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = t(:'feed.postings.title').html_safe

    # the news items
    @posting_items = PostingCategory.post_cat.postings.published.approved.limit(100)

    # this will be our Feed's update timestamp
    @updated = @posting_items.first.updated_at unless @posting_items.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  private

  def postings
    @postings ||= if user.present?
      user.postings
    else
    Posting.published.approved
    end
  end
  helper_method :postings

  def posting
    @posting ||= if params[:id]
      Posting.find params[:id]
    else
      Posting.new params[:posting]
    end
  end
  helper_method :posting

  def user
      @user ||= User.find params[:user_id] if params[:user_id]
  end
  helper_method :user

  def require_owner
    unless current_user.administrator?
      unless current_user == posting.user
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end
