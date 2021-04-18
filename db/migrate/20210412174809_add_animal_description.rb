class AddAnimalDescription < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :description, :string
  end
end
