require 'spec_helper'

describe UsersController do
  it 'should render index' do
    get :index
    response.should be_success
  end
end
