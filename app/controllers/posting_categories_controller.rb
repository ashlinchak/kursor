class PostingCategoriesController < ApplicationController

  def index
  end

  def show
  end

  private

  def posting_categories
    @posting_categories = if params[:id]
    else
      root_posting_categories
    end
  end
  helper_method :posting_categories

  def posting_category
    @posting_category = if params[:id]
      PostingCategory.find_by_permalink(params[:id])
    else
      PostingCategory.new(params[:posting_category])
    end
  end
  helper_method :posting_category

  def postings

    @postings ||= if posting_category.root?
      Kaminari.paginate_array(posting_category.postings.approved).page(params[:page]).per(30)
    else
      Kaminari.paginate_array(posting_category.sub_postings.approved).page(params[:page]).per(30)
    end

  end
  helper_method :postings

  def all_postings
     @postings = Kaminari.paginate_array(Posting.approved).page(params[:page]).per(30)
  end
  helper_method :all_postings



end
