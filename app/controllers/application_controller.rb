class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def categories
    @categories = Category.roots
  end
  helper_method :categories

end
