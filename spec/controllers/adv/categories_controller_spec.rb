require File.dirname(__FILE__) + '/../spec_helper'

describe Adv::CategoriesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Adv::Category.first
    response.should render_template(:show)
  end
end
