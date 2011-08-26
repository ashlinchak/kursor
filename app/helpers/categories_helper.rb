module CategoriesHelper

  def breadcrumbs_for_category category
    result = ''
    if !category.parent.nil?
      result += breadcrumbs_for_category category.parent
      result += "> #{link_to category.parent, category.parent}"
    end
    raw result
  end
end
