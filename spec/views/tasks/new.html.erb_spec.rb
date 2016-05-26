require 'rails_helper'

describe "tasks/new", :type => :view do
  it "should display existing value if present" do
    task = Task.new(from_address: "foobar")
    assign(:task, task)

    render

    expect(rendered).to have_selector("input[value=#{task.from_address}]")
  end

  it "should display error message if present" do
    task = Task.new(from_address: "foobar")

    expect(task).not_to be_valid

    assign(:task, task)

    render

    task.errors.full_messages.each do |msg|
      expect(rendered).to have_content(msg)
    end
  end
end
