class AssociationStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :associations, :active, :boolean, default: true
  end
end
