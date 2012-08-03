class StudentsController < ApplicationController

  def join
    provider.students.create(:user => user, :start_at => Time.now)
    flash[:success] = t('students.joined', :provider => provider)
    redirect_to provider

  end

  def leave
    student.destroy
    flash[:success] = t('students.leaved', :provider => provider)
    redirect_to provider
  end

  private

  def user
    @user ||= current_user
  end

  def provider
    @provider ||= if params[:provider_id]
      Provider.find params[:provider_id]
    end
  end

  def student
    @student ||= provider.students.where(:user_id => user.id).last
  end

end
