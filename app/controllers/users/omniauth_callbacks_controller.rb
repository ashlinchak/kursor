class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  # TODO Переделать алгоритм в один универсальный екшн для любого провайдера


  def google_oauth2

    if request.env['omniauth.params'].present?  # In this case new user will be created

      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
      if @user.persisted?
        set_flash_message(:success, :success, :kind => "Google") if is_navigational_format?
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end

    else

      omniauth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        unless current_user
          set_flash_message(:success, :success, :kind => "Google") if is_navigational_format?
          sign_in_and_redirect authentication.user
        else
          flash[:info] = t(:'devise.failure.already_authenticated')
          redirect_to user_path(current_user)
        end

      elsif current_user
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:success] =  t(:'devise.authentications.flash.successfully_added_authentication', :provider => omniauth['provider'].titleize)
        redirect_to user_path(current_user)
      else
        flash[:error] = t(:'devise.authentications.flash.this_oauth_not_linked_with_any_users', :provider => omniauth['provider'].titleize)
        redirect_to :home
      end

    end

  end

  def facebook

    if request.env['omniauth.params'].present?  # In this case new user will be created

      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        set_flash_message(:success, :success, :kind => "Facebook") if is_navigational_format?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end

    else

      omniauth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        unless current_user
          set_flash_message(:success, :success, :kind => "Facebook") if is_navigational_format?
          sign_in_and_redirect authentication.user
        else
          flash[:info] = t(:'devise.failure.already_authenticated')
          redirect_to user_path(current_user)
        end

      elsif current_user
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:success] =  t(:'devise.authentications.flash.successfully_added_authentication', :provider => omniauth['provider'].titleize)
        redirect_to user_path(current_user)
      else
        flash[:error] = t(:'devise.authentications.flash.this_oauth_not_linked_with_any_users', :provider => omniauth['provider'].titleize)
        redirect_to :home
      end

    end

  end

  def twitter
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      unless current_user
        set_flash_message(:success, :success, :kind => "Twitter") if is_navigational_format?
        sign_in_and_redirect authentication.user
      else
        flash[:info] = t(:'devise.failure.already_authenticated')
        redirect_to user_path(current_user)
      end

    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:success] = t(:'devise.authentications.flash.successfully_added_authentication', :provider => omniauth['provider'].titleize)
      redirect_to user_path(current_user)
    else
      flash[:error] = t(:'devise.authentications.flash.this_oauth_not_linked_with_any_users', :provider => omniauth['provider'].titleize)
      redirect_to :home
    end
  end

  def vkontakte
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      unless current_user
        set_flash_message(:success, :success, :kind => t(:'devise.authentications.providers.vkontakte')) if is_navigational_format?
        sign_in_and_redirect authentication.user
      else
        flash[:info] = t(:'devise.failure.already_authenticated')
        redirect_to user_path(current_user)
      end

    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:success] = t(:'devise.authentications.flash.successfully_added_authentication', :provider => omniauth['provider'].titleize)
      redirect_to user_path(current_user)
    else
      flash[:error] = t(:'devise.authentications.flash.this_oauth_not_linked_with_any_users', :provider => omniauth['provider'].titleize)
      redirect_to :home
    end
  end

end