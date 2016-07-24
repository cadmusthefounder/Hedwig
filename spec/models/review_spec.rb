require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:each) do
    @first_review = reviews(:first_review)
  end

  it "rating should be present" do
    expect(@first_review).to be_valid

    @first_review.rating= ""

    expect(@first_review).not_to be_valid
  end

  it "comment should be present" do
    expect(@first_review).to be_valid

    @first_review.comment = ""

    expect(@first_review).not_to be_valid
  end

  it "comment should not be longer than 140 characters" do
    expect(@first_review).to be_valid

    @first_review.comment = "a" *150

    expect(@first_review).not_to be_valid
  end

  it "rating should be a number" do
    expect(@first_review).to be_valid

    @first_review.rating = "hi"

    expect(@first_review).not_to be_valid
  end

  it "rating should be >= 0" do
    expect(@first_review).to be_valid

    @first_review.rating = -1

    expect(@first_review).not_to be_valid

    @first_review.rating = 0

    expect(@first_review).to be_valid
  end

  it "rating should be <= 5" do
    expect(@first_review).to be_valid

    @first_review.rating = 6

    expect(@first_review).not_to be_valid

    @first_review.rating = 5

    expect(@first_review).to be_valid
  end
end
