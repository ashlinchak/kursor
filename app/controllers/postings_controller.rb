class PostingsController < ApplicationController
  def index
  end

  def show
  end

  def new
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

  def postings
    @postings ||= if params[:user_id]
      Posting.where( :user_id => params[:user_id])
    else
      Posting.all
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

end
