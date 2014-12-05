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

  it 'embeds linked resources' do
    assert_friends('Bob', ['Jill', 'Jack'])
    assert_friends('Jill', ['Bob', 'Jack'])
    assert_friends('Jack', ['Bob', 'Jill'])
  end

  it 'preserves embedded resources original state' do
    assert_friends_state('Bob', ['Jill', 'Jack'])
    assert_friends_state('Jill', ['Bob', 'Jack'])
    assert_friends_state('Jack', ['Bob', 'Jill'])
  end

  def assert_friends(name, expected_friends)
    path = File.join('people', "#{name.downcase}.md")
    person = site.pages.detect { |page| page.path == path }
    friends = person.data['_embedded']['friends']

    assert_equal expected_friends.count, friends.count
    expected_friends.each do |expected|
      assert friend?(friends, expected), "#{name} has the wrong friends. Expected #{expected}."
    end
  end

  def assert_friends_state(name, friends)
    path = File.join('people', "#{name.downcase}.md")
    page = site.pages.detect { |page| page.path == path }

    assert embedded_friends_dont_have_embedded(page, friends)
  end

  def friend?(friends, name)
    !find_friend(friends, name).nil?
  end

  def find_friend(friends, name)
    friends.detect { |friend| friend['title'] == name }
  end

  def embedded_friends_dont_have_embedded(page, friends)
    friends.each do |friend|
      state = find_friend(page.data['_embedded']['friends'], friend)
      assert_nil state['_embedded']
    end
  end

end
