require 'rails_helper'

RSpec.describe "Login" do
  scenario "User logs in" do
    user = create :user
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(current_path).to eq(links_path)
    expect(page).to have_content(user.email)
  end
end
