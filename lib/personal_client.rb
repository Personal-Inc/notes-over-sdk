require 'oauth2_client'

class PersonalClient
  def initialize(at, client_id)
    @access_token = at
    @client_id = client_id
  end

  def get_list_of_gems
    get(add_client_id "/api/v1/gems/")
  end

  def get_gem(gem_instance_id)
    get(add_client_id "/api/v1/gems/#{gem_instance_id}")
  end

  def write_existing_gem(gem_instance_id, body, client_password)
    put(add_client_id "/api/v1/gems/#{gem_instance_id}", {:body=>body, :headers=>{"Secure-Password"=>client_password }})
  end

  def create_gem(body, client_password)
    post(add_client_id "/api/v1/gems/", {:body=>body, :headers=>{"Secure-Password"=>client_password}})
  end

  def delete_gem(gem_instance_id)
    delete(add_client_id "/api/v1/gems/#{gem_instance_id}")
  end

  protected
  def get(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def post(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def put(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def delete(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  private
  def fire(method_name, resource, params)
    response = @access_token.method(method_name).call(resource, :params => params)
    return response.status, response.parsed
  end

  def add_client_id(url)
    "#{url}?client_id=#{client_id}"
  end

  def client_id
    @client_id
  end
end
