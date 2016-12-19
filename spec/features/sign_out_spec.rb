require 'rails_helper'

RSpec.describe "Sign out" do
  scenario "Logged in user clicks sign out" do
    user = create :user
    login(user)
    click_link "Sign Out"
    expect(current_path).to eq(login_path)
    expect(page).to have_button("Login")
  end
end
