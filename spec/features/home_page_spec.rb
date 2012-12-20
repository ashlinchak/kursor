require 'spec_helper'

feature 'Home Page', %q{
  As an unregistered user
  I want to see the home/landing page
} do
  background do
  end
  scenario "Home page" do
    visit "/"
    page.should have_selector('#home')
  end
end
