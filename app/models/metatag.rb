class Metatag < ActiveRecord::Base

  attr_accessible :additional, :description, :keywords, :metatagable_id, :metatagable_type, :split_keywords, :title

  belongs_to :metatagable, :polymorphic => true



end
