module EventCategoriesHelper
  def breadcrumbs_for_event_category event_category
    result = ''
    if !event_category.parent.nil?
      result += breadcrumbs_for_event_category event_category.parent
    end
    result += " <li><span class='divider'>/</span> #{link_to event_category, event_category} </li>"
    raw result
  end
end
