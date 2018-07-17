require 'rails_helper'

RSpec.describe "requests/show", type: :view do
  before(:each) do
    @animal = FactoryBot.create(:animal)
    @request = assign(:request, FactoryBot.create(:request, animal_id: @animal.id))
    @other_types = assign(:other_types, @animal.other_types)
  end

  it "renders attributes in <p>" do
    render
  end
end
