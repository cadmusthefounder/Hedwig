module AccountKit
  TOKEN_EXCHANGE_URL = "https://graph.accountkit.com/v1.0/access_token"
  ME_URL = "https://graph.accountkit.com/v1.0/me"

  cattr_accessor :app_id, :app_secret, :api_version

  def self.app_id
    Rails.configuration.x.facebook_app_id
  end

  def self.app_secret
    Rails.configuration.x.account_kit_app_secret
  end

  def self.api_version
    Rails.configuration.x.account_kit_app_version
  end

  def self.access_token(authorization_code)
    params = {
      grant_type: 'authorization_code',
      code: authorization_code,
      access_token: "AA|#{app_id}|#{app_secret}"
    }
    response = RestClient.get(TOKEN_EXCHANGE_URL, params: params)
    # TODO error handling
    JSON.parse(response)["access_token"]
  end

  def self.me(access_token)
    response = RestClient.get(ME_URL, params: { access_token: access_token })
    JSON.parse(response)
  end
end
