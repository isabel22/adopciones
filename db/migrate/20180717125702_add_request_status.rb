# frozen_string_literal: true

class AddRequestStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default(
      :requests,
      :status,
      from: nil,
      to: 'pending'
    )
  end
end
