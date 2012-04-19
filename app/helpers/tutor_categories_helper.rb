module TutorCategoriesHelper
  def breadcrumbs_for_tutor_category tutor_category
    result = ''
    if !tutor_category.parent.nil?
      result += breadcrumbs_for_tutor_category tutor_category.parent
    end
    result += " <li><span class='divider'>/</span> #{link_to tutor_category, tutor_category} </li>"
    raw result
  end
end