class Admin::PostingsController < Admin::DashboardController
  def index
  end

  def show
  end

  def new
  end

  def create
    posting.user = current_user
    if posting.save
      redirect_to admin_posting_path(posting), :notice => t(:'postings.create.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if posting.update_attributes params[:posting]
      redirect_to admin_posting_path(posting), :notice => t(:'postings.create.success')
    else
      render :new
    end
  end

  def destroy
    posting.destroy
    redirect_to admin_postings_path
  end

  def approve
    if posting.approve!
      flash[:notice]= t(:'postings.approve.success')
    else
      flash[:notice]= t(:'postings.approve.error')
    end
    redirect_to admin_postings_path
  end

  def decline
    if posting.decline!
      flash[:notice]= t(:'postings.decline.success')
    else
      flash[:notice]= t(:'postings.decline.error')
    end
    redirect_to admin_postings_path
  end

  def postings
    @postings ||= Posting.all
  end
  helper_method :postings

  def posting
    @postings ||= if params[:id]
      Posting.find params[:id]
    else
      Posting.new params[:posting]
    end
  end
  helper_method :posting

end
