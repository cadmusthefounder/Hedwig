require 'rails_helper'

RSpec.describe "reviews/new", type: :view do
  before(:each) do
    @user = users(:yihang)
    assign(:user, @user)
    assign(:review, Review.new)
  end

  it "renders new review form" do
    render

    assert_select "form[action=?][method=?]", user_reviews_path(user_id: @user.id), "post" do
      assert_select ".stars-input"
      assert_select "textarea#review_comment[name=?]", "review[comment]"
    end
  end
end
