module CategoriesHelper
  def breadcrumbs_for_category category
    result = ''
    if !category.parent.nil?
      result += breadcrumbs_for_category category.parent
    end
    result += " <li><span class='divider'>/</span> #{link_to category, category} </li>"
    raw result
  end
end