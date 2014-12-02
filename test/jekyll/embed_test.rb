require 'jekyll/embed'
require 'minitest/autorun'

describe 'Jekyll::Embed' do

  let(:config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'permalink' => 'pretty',
      'quiet' => true
    })
  end

  let(:site) { Jekyll::Site.new(config) }

  before(:each) do
    site.process
  end

  it 'does nothing' do
  end

end
