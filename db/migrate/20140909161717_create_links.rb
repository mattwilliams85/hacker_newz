class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.integer :upvotes
      t.integer :downvotes


      t.timestamps
    end
  end
end
