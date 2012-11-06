module UserHelper

  def authenticate_with_button(provider, icon_name, icon_size)
    link_to omniauth_authorize_path(:user, provider), :class => 'auth_provider sign_in_with_provider', :style => 'margin-right:10px;', :title => t(:'devise.authentications.authenticate_with_buttons.title', :provider => provider.to_s.titleize), 'data-content' => t(:'devise.authentications.authenticate_with_buttons.description', :provider => provider.to_s.titleize) do
      image_tag "icons/#{icon_name}", :size => "#{icon_size}", :alt => provider.to_s.titleize
    end
  end

end