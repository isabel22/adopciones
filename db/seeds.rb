# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Perro', 'Gato', 'Ave', 'Roedor'].each do |specimen|
  unless (AnimalSpecy.where(name: specimen).count > 0)
    AnimalSpecy.create(name: specimen)
  end
end

`bin/rake db:seed:dogs`
`bin/rake db:seed:cats`
`bin/rake db:seed:birds`
`bin/rake db:seed:rodents`

`bin/rake db:seed:roles`
