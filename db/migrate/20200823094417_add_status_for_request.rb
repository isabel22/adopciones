class AddStatusForRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :form_status, :string
  end
end
