require 'rails_helper'

RSpec.describe "Links index" do
  scenario "has a form to create links" do
    user = create :user
    login(user)
    expect(page).to have_field("Title")
    expect(page).to have_field("Url")
  end
end
