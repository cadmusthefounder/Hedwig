require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @yihang = users(:yihang)
    @other = users(:other)
    @yihangs_session = sessions(:yihangs_session)
    cookies[:remember_token] = @yihangs_session.remember_token
  end

  it "should get new" do
    @yihang.tasks.create(from_address: "Hi", from_postal_code: "123456",
                         to_address: "Bye", to_postal_code: "123456",
                         price: 12, assigned_user_id: @other.id, status: "completed")
    get :new, params: {user_id: @other.id}
    expect(response).to be_success
  end

  it "should not get new" do
    @yihang.tasks.clear
    get :new, params: {user_id: @other.id}
    expect(response).to_not be_success
  end

  it "should create review when all the required params are present" do
    review_params = {rating: 3, comment: "Fast and efficient"}
    post :create, {params: {user_id: @yihang.id, review: review_params}}
    expect(response).to redirect_to user_path(@yihang)
  end
end
