require 'rails_helper'

describe "#put to /links/:id", type: :request do
  it "returns the updated link as json" do
    user = create :user
    link = create :link, user: user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    put "/api/v1/links/#{link.id}", link: { title: "Turing School", url: "http://www.turing.io", status: "1"}
    link = JSON.parse(response.body)

    expect(response).to be_success
    expect(link).to be_instance_of(Hash)
    expect(link["id"]).to eq(Link.first.id)
    expect(link["title"]).to eq("Turing School")
    expect(link["url"]).to eq("http://www.turing.io")
    expect(link["status"]).to eq(1)
  end
end
