class AddPolymorphicToContacts < ActiveRecord::Migration
  def up
    change_table :contacts do |t|
      t.references :contactable, :polymorphic => true
    end
  end

  def down
    change_table :contacts do |t|
      t.remove :contactable_type, :contactable_id
      t.integer :provider_id
    end
    #Contact.all.each{ }
  end
end
