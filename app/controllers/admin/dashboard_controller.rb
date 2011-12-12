class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_filter :require_authorization
end
