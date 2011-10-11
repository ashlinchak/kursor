class Admin::UsersController < ApplicationController
  before_filter :require_authorization

  def index

  end
end
