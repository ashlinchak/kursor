class StudentsController < ApplicationController

  def join
    provider.students.create(:user => user, :start_at => Time.now)
    redirect_to provider, :notice => "You claimed that you are student at #{provider}!"
  end

  def leave
    student.destroy
    redirect_to provider, :notice => "You claimed that you are not a student at #{provider} anymore!"
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
