module PostingCategoriesHelper
  def breadcrumbs_for_posting_category posting_category
    result = ''
    if !posting_category.parent.nil?
      result += breadcrumbs_for_posting_category posting_category.parent
    end
    result += " <li><span class='divider'>/</span> #{link_to posting_category, posting_category} </li>"
    raw result
  end
end
