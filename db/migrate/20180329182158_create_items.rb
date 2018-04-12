class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
    	t.string :name
    	t.string :description
    	t.float :price
    	t.integer :quantity
    	t.float :totalprice
      t.timestamps
    end
  end
end
