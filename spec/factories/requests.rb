FactoryBot.define do
  factory :request do
    uid "101018882939"
    first_name "Joe"
    last_name "Doe"
    email "joe.doe+test0@gmail.com"
    animal_id {FactoryBot.create(:animal).id}
    country "Guatemala"
    other_pets false
    all_agree true
    type_of_home "apartment"
    own_home false
    place_to_be "inside the apartment"
    place_to_sleep "my bed"
    has_garden true
    can_escape false
    signature "JD"
    status "Pending"
  end
end
