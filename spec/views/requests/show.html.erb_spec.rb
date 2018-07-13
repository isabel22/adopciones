require 'rails_helper'

RSpec.describe "requests/show", type: :view do
  before(:each) do
    @request = assign(:request, FactoryBot.create(:request))
  end

  it "renders attributes in <p>" do
    render
  end
end
