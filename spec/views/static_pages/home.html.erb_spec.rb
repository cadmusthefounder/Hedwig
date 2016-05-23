require "rails_helper"

describe "static_pages/home.html.erb" do
  it "should have the correct title" do
    render template: "static_pages/home.html.erb", layout: "layouts/application"

    expect(rendered).to have_title("Home | Hedwig")
  end
end
