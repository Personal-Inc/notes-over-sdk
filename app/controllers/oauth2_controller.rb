class Oauth2Controller < ApplicationController
  def start_auth
    @oauth_client = Oauth2Client.initialize_from_configuration
    redirect_to @oauth_client.authorize_url
  end

  def callback
    @personal_client = PersonalClient.new @oauth_client.get_access_token(params[:code], @oauth_client.callback_uri)
  end
end
