class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
    	t.belongs_to :story
    	t.belongs_to :user

      t.timestamps
    end
  end
end
