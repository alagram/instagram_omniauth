require 'rails_helper'

RSpec.feature "SignInProcess", type: :feature do
  background do
    visit root_path

    OmniAuth.config.test_mode = true
  end

  scenario "with valid credentials", :vcr do

    OmniAuth.config.add_mock(:instagram, {uid: '5702001256', credentials: {token: '7097534881.a2164f4.a0cc5a573ba347f097f9745b59c7cc09'}})

    click_link "Log in with Instagram"

    expect(page).to have_content("Signed in successfully.")
  end

  scenario "with invalid credentials" do
    OmniAuth.config.mock_auth[:instagram] = :invalid_credentials

    click_link "Log in with Instagram"

    expect(page).to_not have_content("Signed in successfully.")
  end
end
