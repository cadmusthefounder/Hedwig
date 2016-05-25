require "rails_helper"

describe "static_pages/terms_of_use.html.erb" do
  it "should have the correct title" do
    render template: "static_pages/terms_of_use.html.erb", layout: "layouts/application"
    expect(rendered).to have_title(/^Terms of Use | Hedwig$/)
  end
end

