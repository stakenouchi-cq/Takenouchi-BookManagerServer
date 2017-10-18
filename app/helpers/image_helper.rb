require 'httpclient'

module ImageHelper
  URL = 'https://api.imgur.com/3/image'

  def upload_to_imgur(image_string)
    http_client = HTTPClient.new
    auth_header = { 'Authorization' => 'Client-ID 61073815e3d76a2' }
    parameters = { :image => image_string, :type => 'base64' }
    res = http_client.post(URI.parse(URL), parameters, auth_header)

    result_hash = JSON.load(res.body)
    return result_hash['data']['link']
  end

end
