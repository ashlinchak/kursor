class PostingsController < ApplicationController
  def index
  end

  def show
  end

  def postings
    @postings ||= Posting.all
  end
  helper_method :postings

  def posting
    @postings ||= if params[:id]
      Posting.find params[:id]
    end
  end
  helper_method :posting
end
