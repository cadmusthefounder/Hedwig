require 'rails_helper'

describe "tasks/show", :type => :view do
  it "should have the relevant details" do
    task = tasks(:first_task)
    assign(:task, task)

    render

    expect(rendered).to have_content(task.from_address)
    expect(rendered).to have_content(task.from_postal_code)
    expect(rendered).to have_content(task.to_address)
    expect(rendered).to have_content(task.to_postal_code)
    expect(rendered).to have_content(number_to_currency(task.price))
  end
end
