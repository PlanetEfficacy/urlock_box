require 'rails_helper'

describe "#put to /links/:id", type: :request do
  let (:user) { create :user }
  let (:link) { create :link, user: user }

  it "returns the updated link as json" do
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

  it "returns an error if link is invalid because of bad url" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    put "/api/v1/links/#{link.id}", link: { title: "Turing School", url: "Hello world!", status: "1"}
    error = JSON.parse(response.body)

    expect(response).to have_http_status(:bad_request)
    expect(error["message"]).to eq("Url is not a valid URL")
  end
end
