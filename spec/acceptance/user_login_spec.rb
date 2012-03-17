require 'spec_helper'

feature 'Log In Page', %q{
  As a registered user
  I want to login with my account
} do
  background do
    @user = FactoryGirl.create(:user)
  end
  scenario "Click Log In" do
    click_sign_in
    page.should have_selector('#new_user')
  end

  scenario "Log In failure with non-activated account" do
    #click_sign_in
    visit login_path
    page.should have_selector('#new_user')

    within 'form#new_user' do
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'user_password', with: 'password'
      click_button(I18n.t 'sessions.create.button')
    end

    current_path.should == login_path
    page.should have_content(I18n.t 'user_activation.errors.user_inactive')
  end

  scenario 'Log In successfully with activated account' do
    activate_user(@user)
    visit login_path
    page.should have_selector('#new_user')

    within 'form#new_user' do
      fill_in 'user_email', with: 'user1@example.com'
      fill_in 'user_password', with: 'password'
      click_button(I18n.t 'sessions.create.button')
    end
    #current_path.should == user_path(@user)
    page.should have_content(I18n.t 'sessions.create.success')
  end

end
