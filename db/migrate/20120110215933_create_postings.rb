class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string :title
      t.text :excerpt
      t.text :body
      t.references :user

      t.timestamps
    end
    add_index :postings, :user_id
  end
end
