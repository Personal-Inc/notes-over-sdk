require 'oauth2_client'

class PersonalClient
  def initialize(at)
    @access_token = at
  end

  def get_list_of_gems
    get('/api/v1/gems')
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
end
