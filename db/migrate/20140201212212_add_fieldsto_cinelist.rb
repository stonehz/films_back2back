class AddFieldstoCinelist < ActiveRecord::Migration
  def up
    add_column :cinelists, :name, :string
    add_column :cinelists, :api_id, :integer

    add_index :cinelists, :api_id
  end

  def down
    remove_index :cinelists ,:api_id
    remove_column :cinelists, :name
    remove_column :cinelists, :api_id
  end
end
