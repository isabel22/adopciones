# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'requests/index', type: :view do
  before do
    user = FactoryBot.create(:requester)
    sign_in user

    assign(:requests, [
             FactoryBot.create(:request),
             FactoryBot.create(:request)
           ])
  end

  it 'renders a list of requests' do
    render
  end
end
