class TagsController < ApplicationController
  def index

  end

  # accepts name
  def show
    @tag_name = params[:id]
    @tag = Tag.find_by_name @tag_name
    @taggings = @tag.taggings
    @taggables = @taggings.collect{|tagging| tagging.taggable_type.classify.constantize.find(tagging.taggable_id) }
  end
end
