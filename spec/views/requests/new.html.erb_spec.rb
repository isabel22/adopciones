require 'rails_helper'

RSpec.describe "requests/new", type: :view do
  before(:each) do
    user = FactoryBot.create(:requester)
    sign_in user

    assign(:request, Request.new())
    @animal = assign(:animal, FactoryBot.create(:animal))
    assign(:other_types, @animal.other_types)
    assign(:countries, YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml')).values)
  end

  it "renders new request form" do
    render
  end
end
