require 'rails_helper'

describe "#get to /read", type: :request do
  it "returns the requesting user's unread links as json" do
    user = create :user, email: "jeff@example.com"
    create_list :link, 2, user: user, status: 0
    read_link = create :link, user: user, status: 1
    create :link
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    get "/api/v1/unread"
    links = JSON.parse(response.body)

    expect(response).to be_success
    expect(links).to be_instance_of(Array)
    expect(links.count).to eq(2)
    expect(links.first["user_id"]).to eq(user.id)
    expect(links.last["user_id"]).to eq(user.id)
    expect(links.any? { |link| link["id"] == read_link.url }).to eq(false)
  end
end
