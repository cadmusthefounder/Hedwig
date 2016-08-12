require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe "gravatar_for" do
    it "should return the correct image tag" do
      user = users(:yihang)
      hash = "f8d12fea91c32c708e346cf2b005a0b7"
      size = 80

      output = gravatar_for(user, size: size)

      url = "https://secure.gravatar.com/avatar/#{hash}?s=#{size}"

      expect(output).to eq image_tag(url, alt: user.name, class: "gravatar")
    end
  end
end
