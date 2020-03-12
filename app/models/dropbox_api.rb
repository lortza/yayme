# frozen_string_literal: true

class DropboxApi
  DOMAIN = 'www.dropbox.com'
  READABLE_DOMAIN = 'dl.dropboxusercontent.com'

  def self.format_url(url)
    url.gsub('?dl=0', '').gsub(DOMAIN, READABLE_DOMAIN)
  end
end
