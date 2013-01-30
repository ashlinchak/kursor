require File.dirname(__FILE__) + '/../spec_helper'

describe Adv::PostingsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Adv::Posting.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Adv::Posting.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Adv::Posting.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(adv_posting_url(assigns[:adv_posting]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Adv::Posting.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Adv::Posting.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Adv::Posting.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Adv::Posting.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Adv::Posting.first
    response.should redirect_to(adv_posting_url(assigns[:adv_posting]))
  end

  it "destroy action should destroy model and redirect to index action" do
    adv_posting = Adv::Posting.first
    delete :destroy, :id => adv_posting
    response.should redirect_to(adv_postings_url)
    Adv::Posting.exists?(adv_posting.id).should be_false
  end
end
