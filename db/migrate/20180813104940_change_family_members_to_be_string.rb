class ChangeFamilyMembersToBeString < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :family_members, :string
  end
end
