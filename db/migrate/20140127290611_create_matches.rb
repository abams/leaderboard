class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :league, null: false
    	t.string :type
    	t.text :score
      t.timestamps
    end
  end
end
