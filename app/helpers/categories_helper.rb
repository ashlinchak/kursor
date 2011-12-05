module CategoriesHelper
  def breadcrumbs_for_category category
    result = ''
    if !category.parent.nil?
      result += breadcrumbs_for_category category.parent
    end
    result += " / #{link_to category, category}"
    raw result
  end
end
