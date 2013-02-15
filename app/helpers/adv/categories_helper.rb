module Adv::CategoriesHelper

  def breadcrumbs_for_adv_category adv_category
    result = ''
    if !adv_category.is_root?
      result += breadcrumbs_for_category adv_category.parent
    end
    result += " <li><span class='divider'>/</span> #{link_to adv_category, adv_category} </li>"
    raw result
  end


end
