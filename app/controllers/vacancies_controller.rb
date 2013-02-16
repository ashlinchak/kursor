  class VacanciesController < ApplicationController

    before_filter :authenticate_user!, :except => [:index, :show]
    before_filter :require_owner, :only => [:edit, :update, :destroy]

    def index
      @vacancyable = find_vacancyable
      if current_user.administrator? || (current_user == Provider.find(params[:provider_id]).user)
        @vacancies = @vacancyable.vacancies
      else
        @vacancies = @vacancyable.vacancies.active
      end
    end

    def show
      @vacancy = Vacancy.find(params[:id])
      @provider = Provider.find(params[:provider_id])
    end

    def new
      @provider = Provider.find(params[:provider_id])
      @vacancy = @provider.vacancies.new
      @vacancy_title = t(:'vacancies.new.new_vacancy')
    end

    def create
      @vacancyable = find_vacancyable
      @vacancy = @vacancyable.vacancies.build(params[:vacancy])
      @provider = Provider.find(params[:provider_id])
      if @vacancy.save
        flash[:success] = t(:'vacancies.new.vacancy_added').html_safe
        redirect_to provider
      else
        # flash[:error] = t(:'tutors.create.error').html_safe
        render :action => 'new'
      end
    end

    def edit
      @vacancy = Vacancy.find(params[:id])
      @provider = Provider.find(params[:provider_id])
      @vacancy_title = t(:'vacancies.edit.edit_vacancy')
    end

    def update
      @vacancy = Vacancy.find(params[:id])

      if @vacancy.update_attributes(params[:vacancy])
        flash[:success] = t(:'vacancies.edit.success').html_safe
        redirect_to provider_path(provider)
      else
        render :action => "edit"
      end
    end

    def destroy
      @vacancy = Vacancy.find(params[:id])
      @vacancy.destroy
      flash[:success] = t(:'vacancies.delete.success').html_safe
      redirect_to provider_path(provider)
    end

    private

    def provider
      @provider ||= if params[:provider_id]
        Provider.find(params[:provider_id])
      end
    end
    helper_method :provider

    def find_vacancyable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

    def require_owner
      unless current_user.administrator?
        unless current_user == Provider.find(params[:provider_id]).user
          #rescue ActiveRecord::RecordNotFound
          flash[:error] = t('site.errors.access_denied')
          redirect_to root_path
        end
      end
    end
  end
