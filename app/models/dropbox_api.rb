# frozen_string_literal: true

class DropboxApi
  DOMAIN = 'www.dropbox.com'
  READABLE_DOMAIN = 'dl.dropboxusercontent.com'

  def self.format_url(url)
    url.gsub('?dl=0', '').gsub(DOMAIN, READABLE_DOMAIN)
  end
end


# Content-upload endpoints
# These endpoints accept file content in the request body, so their arguments are instead passed as
# JSON in the Dropbox-API-Arg request header or arg URL parameter. These endpoints are on the
# content.dropboxapi.com domain.
# https://www.dropbox.com/developers/documentation/http/documentation#file_requests-get
