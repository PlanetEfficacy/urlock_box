require 'rails_helper'

describe "#post to /links", type: :request do
  it "returns the created link as json" do
    user = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/api/v1/links", link: { title: "Great Link", url: "www.google.com"}
    link = JSON.parse(response.body)

    expect(response).to be_success
    expect(link).to be_instance_of(Hash)
    expect(link["id"]).to eq(Link.first.id)
    expect(link["title"]).to eq(Link.first.title)
    expect(link["url"]).to eq(Link.first.url)
  end
end
