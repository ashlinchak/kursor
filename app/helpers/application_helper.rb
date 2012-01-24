module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    #Redcarpet.new(text, *options).to_html.html_safe
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("/" + association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def format_location location
    result = ""
    result << "#{location.city}" if location.city
    result << ", #{location.street}" if location.street
    result << ", #{location.building}" if location.building
    result << ", apt. #{location.apartment}" if location.apartment
    result
  end

  def contact_value contact
    if contact.contact_type.to_sym == :url
      cleaned = contact.value.gsub(/http:\/\//,'')
      url = "http://#{cleaned}"
      link_to cleaned, url, :rel => 'nofollow', :target => '_blank'
    elsif contact.contact_type.to_sym == :email
      link_to contact.value, "mailto:#{contact.value}"
    else
      contact.value
    end
  end

  def address_value location
    if location
      # "#{provider.location.city.region}, "
      ( !location.custom_city.blank? ?
        "#{location.custom_city.strip}, " :
        "#{location.city}, " ) +
      "#{location.street.strip}, " +
      "#{location.building.strip}" +
      ( !location.apartment.blank? ?
       ', room ' + location.apartment : '' )
    end
  end

  def links_to_tags tags_list
    links = []
    tags_list.collect{ | tag |
      links << link_to(tag, tag)
    }
    sanitize links.join(", ")
  end

  def commas_to_tags tags_list
    tags_list.join(", ")
  end

end
