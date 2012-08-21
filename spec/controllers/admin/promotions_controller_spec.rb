require 'spec_helper'

describe Admin::PromotionsController do
  before do
    @admin = FactoryGirl.create(:user)
    @admin.create_administrator
    session[:user_id] = @admin.id
  end

  it 'should render index' do
    get :index
    response.should be_success
    response.should render_template('index')
  end
end
