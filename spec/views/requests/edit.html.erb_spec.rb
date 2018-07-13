require 'rails_helper'

RSpec.describe "requests/edit", type: :view do
  before(:each) do
    animal = FactoryBot.create(:animal)
    @request = assign(:request, FactoryBot.create(:request, animal_id: animal.id))
    @other_types = assign(:other_types, animal.other_types)
  end

  it "renders the edit request form" do
    render
  end
end
