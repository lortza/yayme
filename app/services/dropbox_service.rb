# frozen_string_literal: true

class DropboxService
  DOMAIN = 'www.dropbox.com'
  READABLE_DOMAIN = 'dl.dropboxusercontent.com'
  UNNECESSARY_PARAMS = '?dl=0'

  def self.format_url(url)
    # converts this: https://www.dropbox.com/s/sample/sample.png?dl=0
    # to this: https://dl.dropboxusercontent.com/s/sample/sample.png
    url.gsub(UNNECESSARY_PARAMS, '').gsub(DOMAIN, READABLE_DOMAIN)
  end
end
