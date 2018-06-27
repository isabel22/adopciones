# # Add Dog breeds
# dog = AnimalSpecy.where(name: 'Perro').first
# dog_id = dog.id
require 'csv'

namespace :db do
  namespace :seed do
    desc "Seed Dogs from /db/seeds/dogs.csv"
    task :dogs => :environment do
      db_seed_dogs
    end

    desc "Seed Cats from /db/seeds/cats.csv"
    task :cats => :environment do
      db_seed_cats
    end

    desc "Seed Birds from /db/seeds/birds.csv"
    task :birds => :environment do
      db_seed_birds
    end
  end
end


private

def db_seed_dogs
  csv_text = File.read(Rails.root.join('db', 'seeds', 'dogs.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  dog = AnimalSpecy.where(name: 'Perro').first
  dog_id = dog.id
  csv.each do |row|
    breed = row['breed']
    unless (AnimalBreed.where(name: breed, animal_species_id: dog_id).count > 0)
      AnimalBreed.create(name: breed, animal_species_id: dog_id)
    end
  end
end

def db_seed_cats
  csv_text = File.read(Rails.root.join('db', 'seeds', 'cats.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  cat = AnimalSpecy.where(name: 'Gato').first
  cat_id = cat.id
  csv.each do |row|
    breed = row['breed']
    unless (AnimalBreed.where(name: breed, animal_species_id: cat_id).count > 0)
      AnimalBreed.create(name: breed, animal_species_id: cat_id)
    end
  end
end

def db_seed_birds
  csv_text = File.read(Rails.root.join('db', 'seeds', 'birds.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  bird = AnimalSpecy.where(name: 'Ave').first
  bird_id = bird.id
  csv.each do |row|
    breed = row['breed']
    unless (AnimalBreed.where(name: breed, animal_species_id: bird_id).count > 0)
      AnimalBreed.create(name: breed, animal_species_id: bird_id)
    end
  end
end
