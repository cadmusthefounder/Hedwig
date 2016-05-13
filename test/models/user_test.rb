require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email should be present" do
    @user = users(:yihang)

    assert @user.valid?

    @user.email = ""

    refute @user.valid?
  end

  test "account_kit_id should be present" do
    @user = users(:yihang)

    assert @user.valid?

    @user.account_kit_id = ""

    refute @user.valid?
  end

  test "email should be unique" do
    @user = users(:yihang)

    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    assert another_user.valid?

    another_user.email = @user.email

    refute another_user.valid?

    another_user.email.upcase!

    refute another_user.valid?
  end

    test "account_kit_id should be unique" do
    @user = users(:yihang)

    another_user = User.new(name: "Foo", email: "Bar", account_kit_id: "123")

    assert another_user.valid?

    another_user.account_kit_id = @user.account_kit_id

    refute another_user.valid?
  end
end
