require 'rails_helper'

RSpec.describe "requests/show", type: :view do
  before(:each) do
    user = FactoryBot.create(:requester)
    sign_in user

    @animal = FactoryBot.create(:animal)
    assign(:request, FactoryBot.create(:request, animal_id: @animal.id))
    assign(:other_types, @animal.other_types)
    assign(:countries, YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml')).values)
  end

  it "renders attributes in <p>" do
    render
  end
end
