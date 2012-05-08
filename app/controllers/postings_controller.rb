class PostingsController < ApplicationController
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
      flash[:success] = t(:'postings.create.success')
      redirect_to posting_path(posting)
    else
      render :new
    end
  end

  def edit
    @posting = current_user.postings.find(params[:id])
  end

  def update
    if posting.update_attributes params[:posting]
      flash[:notice] = t(:'postings.update.success')
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
    @postings ||= if params[:user_id]
      Posting.where( :user_id => params[:user_id])
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

  def require_owner
    @posting = current_user.postings.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('permission_denied')
    redirect_to user_postings_path(current_user)
  end

end
