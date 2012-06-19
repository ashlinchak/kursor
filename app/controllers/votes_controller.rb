class VotesController < ApplicationController

  def vote
    vote_value = params[:value].to_i

    if provider
      provider.votes.create(:value => vote_value, :user_id => user.id)
      rating = provider.rating || provider.build_rating
    elsif tutor
      tutor.votes.create(:value => vote_value, :user_id => user.id)
      rating = tutor.rating || tutor.build_rating
    end

    rating.votes_count = rating.votes_count + 1 || 1
    rating.total_value = rating.total_value + vote_value || vote_value
    rating.average_value = (rating.total_value.to_f / rating.votes_count.to_f).round(2)
    rating.save

    render :partial => 'votes/results', :locals => { :rating => rating }

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

  def tutor
    @tutor ||= if params[:tutor_id]
      Tutor.find params[:tutor_id]
    end
  end

end
