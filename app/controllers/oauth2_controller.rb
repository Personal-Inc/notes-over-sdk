require 'personal_client'

class Oauth2Controller < ApplicationController
  def index
    redirect_to Oauth2Client.initialize_from_configuration.authorize_url
  end


  def callback
    oauth_client = Oauth2Client.initialize_from_configuration
    access_token = oauth_client.get_access_token(params[:code], Oauth2Client.callback_uri)
    @personal_client = PersonalClient.new(access_token, oauth_client.client_id)
    render :text => @personal_client.get_list_of_gems.inspect
  end
end
