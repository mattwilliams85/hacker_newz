class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.string :link_id

      t.timestamps
    end
  end
end
