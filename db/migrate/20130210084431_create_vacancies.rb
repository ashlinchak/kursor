class CreateVacancies < ActiveRecord::Migration
	def change
		create_table :vacancies do |t|
			t.string :title
			t.text :requirements
			t.text :responsibility
			t.text :conditions
			t.decimal :salary
			t.boolean :active
			t.references :vacancyable, :polymorphic => true

			t.timestamps
		end
	end
end
