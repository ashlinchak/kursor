class CreateAdvPostings < ActiveRecord::Migration
  def self.up
    create_table :adv_postings do |t|
      t.string :title
      t.integer :adv_category_id
      t.integer :posting_type_id
      t.integer :owner_type_id
      t.text :body
      t.integer :location_id
      t.string :contact_person
      t.string :email
      t.integer :price
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :adv_postings
  end
end
