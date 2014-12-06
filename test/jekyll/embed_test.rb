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

  it 'embeds linked resources' do
    assert_has_friends('Bob', ['Jill', 'Jack'])
    assert_has_friends('Jill', ['Bob', 'Jack'])
    assert_has_friends('Jack', ['Bob', 'Jill'])
  end

  it 'preserves embedded resources original state' do
    assert_friends_state('Bob', ['Jill', 'Jack'])
    assert_friends_state('Jill', ['Bob', 'Jack'])
    assert_friends_state('Jack', ['Bob', 'Jill'])
  end

  def assert_has_brother(name, expected_brother)
    embedded_brother = embedded(name)['brother']
    error = "#{name} has wrong brother. Expected #{expected_brother}."
    assert brother?(embedded_brother, expected_brother), error
  end

  def assert_has_friends(name, expected_friends)
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

  def embedded(name)
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

  def embedded_friends_dont_have_embedded(page, friends)
    friends.each do |friend|
      state = find_friend(page.data['_embedded']['friends'], friend)
      assert_nil state['_embedded']
    end
  end

end
