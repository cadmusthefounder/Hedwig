require "rails_helper"

describe "static_pages/about.html.erb" do
  it "should have the correct title" do
    render template: "static_pages/help.html.erb", layout: "layouts/application"
    expect(rendered).to have_title(/^Help | Hedwig$/)
  end
end

