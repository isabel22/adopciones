# frozen_string_literal: true

class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    remove_column(:requests, :references)

    create_table :references do |t|
      t.string :full_name
      t.string :phone

      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
