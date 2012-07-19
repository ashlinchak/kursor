module TutorCategoriesHelper
  def breadcrumbs_for_tutor_category tutor_category
    result = ' / '
    if !tutor_category.parent.nil?
      result += breadcrumbs_for_tutor_category tutor_category.parent
    end
    result += "<li> #{link_to tutor_category, tutor_category} <span class='divider'>/</span></li>"
    raw result
  end
end