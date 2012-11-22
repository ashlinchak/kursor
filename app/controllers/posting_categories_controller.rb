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
      Kaminari.paginate_array(posting_category.postings.published.approved).page(params[:page]).per(15)
    else
      Kaminari.paginate_array(posting_category.sub_postings.published.approved).page(params[:page]).per(15)
    end
  end
  helper_method :postings

  def all_postings
     @all_postings = Kaminari.paginate_array(text_postings.published.approved).page(params[:page]).per(15)
  end
  helper_method :all_postings

  def video_postings
    @video_postings = Posting.video_postings.published.approved
  end
  helper_method :video_postings

  def text_postings
    @text_postings = Posting.text_postings.published.approved
  end
  helper_method :text_postings

  def posts_only
    @posts_only = Kaminari.paginate_array(post_cat.postings.published.approved).page(params[:page]).per(15)
  end
  helper_method :posts_only

  def blog_only
    @blog_only = Kaminari.paginate_array(blog_cat.postings.published.approved).page(params[:page]).per(15)
  end
  helper_method :blog_only

  def wiki_only
    @wiki_only = Kaminari.paginate_array(wiki_cat.postings.published.approved).page(params[:page]).per(15)
  end
  helper_method :wiki_only

  def video_only
    @video_only = Kaminari.paginate_array(video_cat.postings.published.approved).page(params[:page]).per(15)
  end
  helper_method :video_only


  def post_cat
    @post_cat = PostingCategory.post_cat
  end
  helper_method :post_cat

  def blog_cat
    @blog_cat = PostingCategory.blog_cat
  end
  helper_method :blog_cat

  def wiki_cat
    @wiki_cat = PostingCategory.wiki_cat
  end
  helper_method :wiki_cat

  def video_cat
    @video_cat = PostingCategory.video_cat
  end
  helper_method :video_cat

end
