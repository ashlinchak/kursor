class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create

    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid? && simple_captcha_valid?
      flash[:success] = t(:'feedback.messages.success')
      NotificationMailer.feedback(@feedback).deliver
      redirect_to root_path
    else

      @error_msg = ''

      unless simple_captcha_valid?
        @error_msg += t(:'feedback.messages.failed')
      end

      unless @feedback.valid?
        @error_msg += t(:'feedback.messages.empty_body')
      end

      flash[:error] = ('<ul>'+@error_msg+'</ul>').html_safe
      render :new
    end
  end
end
