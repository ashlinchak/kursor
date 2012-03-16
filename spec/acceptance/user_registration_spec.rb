require 'spec_helper'

feature 'User Registration', %q{
  As an unregistered user
  I want to create an account
} do

  background do
  end

  scenario "Register User" do
    visit "/signup"
    page.should have_selector('form#new_user')

    within 'form#new_user' do
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      choose 'user_account_type_id_0'
      find('.form-actions input[type=submit]').click
    end

    user = User.last
    user.email.should == 'user1@example.com'
    current_path.should == user_path(user)
  end

  scenario 'Activate newly created account' do
    user = FactoryGirl.create(:user)
    visit perform_activation_url(user.user_activation.token)
    page.should have_content( I18n.t('user_activation.perform.success') )
  end
end
