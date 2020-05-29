# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DropboxService, type: :model do
  describe 'self.format_dropbox_url' do
    let(:raw_url) { 'https://www.dropbox.com/s/sample/sample.png?dl=0' }
    let(:processed_url) { 'https://www.dropbox.com/s/sample/sample.png?dl=0' }

    it 'removes unnecessary cruft from end of url' do
      output = DropboxService.format_url(raw_url)
      expect(output).to_not include('?dl=0')
    end

    it 'switches out dropbox domain for usable one' do
      output = DropboxService.format_url(raw_url)

      expect(output).to_not include(DropboxService::DOMAIN)
      expect(output).to include(DropboxService::READABLE_DOMAIN)
    end

    it 'leaves non-dropbox urls as-is' do
      raw_url = 'https://someotherdomain.com/sample1.png'
      output = DropboxService.format_url(raw_url)

      expect(output).to eq(raw_url)
    end
  end
end
