class CommentsController < ApplicationController

  def create
    @posting = Posting.find(params[:posting_id])
    @user_who_commented = current_user
    @comment = Comment.build_from(@posting, @user_who_commented.id, params[:comment][:body])

    if !params[:comment][:parent_id].blank?
      @parent_id = params[:comment][:parent_id]
      @comment.parent_id = @parent_id.to_i
    end

    if @comment.save
      flash[:success] = t(:'postings.comments.messages.create_success')
      redirect_to @posting
    else
      flash[:error] = t(:'postings.comments.messages.create_error')
      redirect_to @posting
    end

  end

  def edit
  end

  def destroy
    @posting = Posting.find(params[:posting_id])
    @comment = Comment.find(params[:id])
    unless @comment.has_children?
      @comment.destroy
      flash[:success] = t(:'postings.comments.messages.destroy_success')
    else
      flash[:error] = t(:'postings.comments.messages.cant_destroy_non_empty')
    end
    redirect_to @posting

  end

end
