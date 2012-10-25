require 'oauth2_client'

class Oauth2Controller < ApplicationController
  def index
    @oauth_client = Oauth2Client.initialize_from_configuration
    redirect_to @oauth_client.authorize_url
  end

  def callback
    @personal_client = PersonalClient.new @oauth_client.get_access_token(params[:code], @oauth_client.callback_uri)
  end
end
