require 'rails_helper'

RSpec.describe "Authorize links index" do
  scenario "unauthenticated user cannot visit links index" do
    visit links_path
    expect(current_path).to eq(login_path)
    expect(page).to have_button("Login")
  end
end
