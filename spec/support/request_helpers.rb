module RequestHelpers
  module Helpers
    def click_sign_in
      visit root_url
      click_link(I18n.t('sessions.create.title'))
    end

    def activate_user(user)
      visit perform_activation_path(user.user_activation.token)
    end

    #def login_user(user)
      #visit new_user_session_path
      #fill_in "Email", :with => "testy@test.com"
      #fill_in "Password", :with => "password"
      #click_button "Sign in"
    #end
  end
end

RSpec.configure do |c|
  c.include RequestHelpers::Helpers, :type => :integration, :example_group => {
    :file_path => c.escaped_path(%w[spec integration])
  }
end

