class Adv::PostingsController < ApplicationController


  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :require_owner, :only => [ :edit, :update, :destroy ]


  def index
  end

  def show
  end

  def new
  end

  def create
    posting.user = current_user
    if posting.save
      redirect_to posting, :notice => "Successfully created adv/posting."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if posting.update_attributes(params[:adv_posting])
      redirect_to posting, :notice  => "Successfully updated adv/posting."
    else
      render :action => 'edit'
    end
  end

  def destroy
    posting.destroy
    redirect_to adv_category_path(posting.category), :notice => "Successfully destroyed adv/posting."
  end

  def publish
    posting.published_at = Time.now
    if posting.save
      redirect_to adv_category_path(posting.category), :notice => "Successfully published!"
    else
      redirect_to adv_category_path(posting.category), :danger => "Fails to publish!"
    end
  end

  def unpublish
    posting.published_at = nil
    if posting.save
      redirect_to adv_category_path(posting.category), :notice => "Successfully UN_published!"
    else
      redirect_to adv_category_path(posting.category), :danger => "Fails to unpublish!"
    end
  end

  def postings
    @postings ||= if params[:id]
                    else
                      Adv::Posting.all
                    end
  end
  helper_method :postings

  def posting
    @category ||= if params[:id]
                    Adv::Posting.find params[:id]
                  else
                    Adv::Posting.new params[:adv_posting]
                  end
  end
  helper_method :posting

  def require_owner
    unless current_user.administrator?
      unless current_user == posting.user
        flash[:error] = t('site.errors.access_denied')
        redirect_to root_path
      end
    end
  end

end
