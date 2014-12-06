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

  it 'embeds linked resource' do
    assert_has_brother('Bob', 'Jack')
    assert_has_brother('Jack', 'Bob')
  end

  it 'embeds linked resource array' do
    assert_has_friends('Bob', ['Jill'])
    assert_has_friends('Jill', ['Bob', 'Jack'])
    assert_has_friends('Jack', ['Jill'])
  end

  it 'does not embed previously embedded resources' do
    check_embedded_for_embedded('Bob')
    check_embedded_for_embedded('Jill')
    check_embedded_for_embedded('Jack')
  end

  def assert_has_brother(name, expected_brother)
    embedded_brother = get_embedded(name)['brother']

    failure = "#{name} has wrong brother. Expected #{expected_brother}."
    assert brother?(embedded_brother, expected_brother), failure
  end

  def assert_has_friends(name, expected_friends)
    friends = get_embedded(name)['friends']

    failure = "#{name} should have #{expected_friends.count} friends."
    assert_equal expected_friends.count, friends.count, failure

    expected_friends.each do |expected|
      failure = "#{name} has the wrong friends. Expected #{expected}."
      assert friend?(friends, expected), failure
    end
  end

  def check_embedded_for_embedded(name)
    embedded = get_embedded(name)

    brother = embedded['brother']
    failure = 'Embedded resources should not contain other embedded resources.'
    assert_nil brother['_embedded'], failure unless brother.nil?

    embedded['friends'].each do |friend|
      assert_nil friend['_embedded'], failure
    end
  end

  def get_embedded(name)
    path = File.join('people', "#{name.downcase}.md")
    page = site.pages.detect { |page| page.path == path }
    page.data['_embedded']
  end

  def brother?(brother, name)
    brother['title'] == name
  end

  def friend?(friends, name)
    !find_friend(friends, name).nil?
  end

  def find_friend(friends, name)
    friends.detect { |friend| friend['title'] == name }
  end

end
