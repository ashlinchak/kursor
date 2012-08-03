class PostingsController < ApplicationController

  before_filter :require_authentication, :except => [:index, :show]

  before_filter :require_owner, :only => [ :edit, :update, :destroy ]

  def index
  end

  def show
  end

  def new
    posting.images.build
  end

  def create
    posting.user = current_user
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
    posting.images.build unless posting.images.size > 0
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

  private

  def postings
    @postings ||= if user.present?
      user.postings
    else
    Posting.approved
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
