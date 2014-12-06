# Jekyll::Embed

Use links to build Jekyll page data.

## Installation

Follow [Jekyll's instructions for installing Jekyll plugins](http://jekyllrb.com/docs/plugins/#installing-a-plugin). The **Jekyll::Embed** plugin is available from the `jekyll-embed` gem.

## Usage

**Jekyll::Embed** relies on two special fields in the Jekyll page front matter to do its thing - `_links` and `_embedded`. These concepts come from the [Hypermedia Application Language (HAL)](http://stateless.co/hal_specification.html) media type specification.

* `_links` is a container of links to other resources
* `_embedded` is a container of other resources

**Jekyll::Embed** finds resources using `_links` and puts them in `_embedded`.

> For the purposes of this plugin, a resource and Jekyll page (specifically its front matter, aka data) can be considered the same thing.

### Steps

1. Define link objects to other resources in a `_links` field as part of the Jekyll page's front matter (aka data). Every link object should have `title` and `href` fields, but this plugin only needs `href` to work.
2. Use the embedded resources in the Jekyll page.

In the following example, Jill has links to her friends Bob and Jack inside of `_links` defined in the `people/jill.md` page.

```yaml
# people/jill.md (front matter only)

title: Jill
age: 6
_links:
  friends:
    - title: Bob
      href: /people/bob

    - title: Jack
      href: /people/jack
```

Below is the data that will be available to the `people/jill.md` page during the Jekyll build process. Notice that Jill's friends Bob and Jack are now included in their entirety in `_embedded` and are available to be displayed on the Jill's page.

```yaml
# people/jill.md (front matter only)

title: Jill
age: 6
_links:
  friends:
    - title: Bob
      href: /people/bob

    - title: Jack
      href: /people/jack

_embedded:
  friends:
    - title: Bob
      age: 5
      _links:
        friends:
          - title: Jill
            href: /people/jill

    - title: Jack
      age: 7
      _links:
        friends:
          - title: Jill
            href: /people/jill
```

## Contributing

1. Fork it (https://github.com/gregoryjscott/jekyll-embed/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request.
