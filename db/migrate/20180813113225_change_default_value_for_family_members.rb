class ChangeDefaultValueForFamilyMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:requests, :family_members, from: "{}", to: nil)
  end
end
