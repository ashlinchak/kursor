class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_filter :require_authorization


  def pending_count
    @pending_count = Tutor.where(:is_approved => false).size + Provider.where(:is_approved => false).size + Posting.where(:is_approved => false).size
  end
  helper_method :pending_count

  def index
    @admin_users = Administrator.all.size
    @cities = City.all.size
    @categories = Category.all.size
    @news = News.all.size
    @posts = Posting.all.size
    @tags = Tag.all.size
    @users = User.last(20).reverse
  end

  def providers_approved
    @providers = Provider.approved.size
  end
  helper_method :providers_approved

  def providers_waiting
    @providers = Provider.where(:is_approved => false).size
  end
  helper_method :providers_waiting

  def today_registered_providers
    @providers = Provider.find(:all, :conditions => [" created_at between ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]).size
  end
  helper_method :today_registered_providers

  def today_registered_tutors
    @providers = Tutor.find(:all, :conditions => [" created_at between ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]).size
  end
  helper_method :today_registered_tutors


def today_news_created
    @news = News.find(:all, :conditions => [" created_at between ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]).size
  end
  helper_method :today_news_created

def today_postings_created
    @posting = Posting.find(:all, :conditions => [" created_at between ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]).size
  end
  helper_method :today_postings_created


end
