require "rails_helper"

describe "static_pages/faq.html.erb" do
  it "should have the correct title" do
    render template: "static_pages/faq.html.erb", layout: "layouts/application"
    expect(rendered).to have_title(/^FAQ | Hedwig$/)
  end
end

