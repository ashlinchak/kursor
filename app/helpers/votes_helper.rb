module VotesHelper


  def vote_stars current_value, disabled

    result = ""
    value = 0
    css_class = ""

    if disabled == true
      css_class = "read_only_star"
    elsif disabled == false
      css_class = "rating_star"
    end

    10.times do
      value += 1
      if current_value == value
        checked = "checked"
      else
        checked = ""
      end
      result << "<input name=\'star1\' value=\'" + value.to_s + "\'" + checked + " class=\'" + css_class + "\'/>"
    end

    result.html_safe

  end


end
