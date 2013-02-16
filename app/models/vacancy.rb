class Vacancy < ActiveRecord::Base

	# getters and setters
	attr_accessible :title, :requirements, :responsibility, :conditions, :salary, :active

	# validators
	validates :title, :presence => true
	validates :requirements, :presence => true
	validates :responsibility, :presence => true
	validates :conditions, :presence => true
	validates :salary, :presence => true

	# joins
	belongs_to :vacancyable, :polymorphic => true

  # scopes
  default_scope order("vacancies.title")
  scope :active, where("vacancies.active = 1")
  scope :not_active, where("vacancies.active = 0")

end
