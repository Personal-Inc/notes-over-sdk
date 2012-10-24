require 'oauth2'

class Oauth2Client
  def initialize(client_id, client_secret, target_site, callback_uri)
    @callback_uri = callback_uri
    @client = OAuth2::Client.new(client_id, client_secret, :site => target_site)
    @authorize_url = @client.auth_code.authorize_url(:redirect_uri => callback_uri)
  end

  def self.initialize_from_configuration
    @@oauth_config = YAML.load_file("#{RAILS_ROOT}/config/oauth2_config.yml") unless @@oauth_config
    Oauth2Client.new(client_id, client_secret, target_site, callback_uri)
  end

  def get_access_token(code, callback_uri)
    @client.auth_code.get_token(code, :redirect_uri => callback_uri)
  end

  def callback_uri
    return @callback_uri if @callback_uri
    @@oauth_config[site]["my_site"] + @@oauth_config[site]["callback_uri"]
  end
 
  private
  def site
    @@oauth_config[@@oauth_config["site"]]
  end
  
  def client_id
    @@oauth_config[site]["client_id"]
  end

  def client_secret
    @@oauth_config[site]["client_secret"]
  end

  def target_site
    @@oauth_config[site]["target_site"]
  end
end
