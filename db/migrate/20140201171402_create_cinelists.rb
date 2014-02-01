class CreateCinelists < ActiveRecord::Migration
  def change
    create_table :cinelists do |t|
      t.string :object_response

      t.timestamps
    end
  end
end
