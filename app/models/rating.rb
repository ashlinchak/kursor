class Rating < ActiveRecord::Base

  belongs_to :voteable, :polymorphic => true

end
