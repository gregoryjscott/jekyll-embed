# Jekyll::Embed

Use hypermedia to build Jekyll page data.

## Installation

Follow [Jekyll's instructions for installing Jekyll plugins](http://jekyllrb.com/docs/plugins/#installing-a-plugin). The **Jekyll::Embed** plugin is available from the `jekyll-embed` gem.

## Usage

**Jekyll::Embed** relies on two special fields in the Jekyll page front matter to do its thing - `_links` and `_embedded`. These concepts come from the Hypermedia Application Language (HAL) media type specification.

* `_links` is a container of links to other resources
* `_embedded` is a container of other resources

**Jekyll::Embed** uses `_links` to populate `_embedded`.

> For the purposes of this plugin, a Jekyll page and resource can be considered the same thing.

### Steps

1. Define `_links` to other resources in each Jekyll page's front matter.

  In the following example, Jill has links to her friends Bob and Jack inside of `_links`.

  ```yaml
  # people/jill.md (front matter only)

  name: Jill
  age: 6
  _links:
    friends:
      - title: Bob
        url: /people/bob

      - title: Jack
        url: /people/jack
  ```

2. Use the embedded resources in the Jekyll pages.

  The following example is the result of embedding the previous example. Notice that Jill's friends are now included in their entirety in `_embedded`.

  ```yaml
  # people/jill.md (front matter only)

  name: Jill
  age: 6
  _links:
    friends:
      - title: Bob
        url: /people/bob

      - title: Jack
        url: /people/jack

  _embedded:
    friends:
      - name: Bob
        age: 5
        _links:
          friends:
            - title: Jill
              url: /people/jill

            - title: Jack
              url: /people/jack

      - name: Jack
        age: 7
        _links:
          friends:
            - title: Bob
              url: /people/bob

            - title: Jill
              url: /people/jill
  ```

## Contributing

1. Fork it (https://github.com/gregoryjscott/jekyll-embed/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request.
