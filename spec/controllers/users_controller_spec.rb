require 'spec_helper'

describe UsersController do
  context 'User signup' do
    let(:valid_user_params) do 
      {
        user: {
          email:                  'user1@example.com',
          password:               'password',
          password_confirmation:  'password'
        }
      }
    end

    let(:invalid_user_params) do 
      {
        user: {
          email:                  'user1@example.com',
          password:               'password1',
          password_confirmation:  'password2'
        }
      }
    end

    it 'should render signup page' do
      get :index
      response.should be_success
      response.should render_template( :index )
    end
    
    it 'should create new valid user' do
      expect{
        post :create, valid_user_params
      }.to change{User.count}.by(1)
    end

    it 'should not create new invalid user' do
      expect{
        post :create, invalid_user_params
      }.not_to change{User.count}.by(1)
    end

    it 'should redirect to user after create' do
      pending "see where should it redirect"
    end

  end
end

