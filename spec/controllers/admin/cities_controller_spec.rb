require 'spec_helper'

describe Admin::CitiesController do
  it 'should render index' do
    get :index
    response.should be_success
  end
end
