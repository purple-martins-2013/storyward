class DropStoriesTags < ActiveRecord::Migration
  def change
  	drop_table :stories_tags
  end
end
