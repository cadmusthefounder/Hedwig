require "rails_helper"

describe "static_pages/privacy_policy.html.erb" do
  it "should have the correct title" do
    render template: "static_pages/privacy_policy.html.erb", layout: "layouts/application"
    expect(rendered).to have_title(/^Privacy Policy | Hedwig$/)
  end
end

