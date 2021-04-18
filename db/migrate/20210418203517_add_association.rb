class AddAssociation < ActiveRecord::Migration[6.0]
  def change
    create_table :associations do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :address
      t.string :home_phone
      t.string :description
      t.string :url
      t.string :photo_url
      t.string :extra_description
      t.string :donation_link
      t.references :animals

      t.timestamps
    end

    add_reference :animals, :association, foreign_key: true
  end
end
