# Jekyll::Embed

Uses hypermedia to combine Jekyll page data.

## Installation

Follow [Jekyll's instructions for installing Jekyll plugins](http://jekyllrb.com/docs/plugins/#installing-a-plugin). The **Jekyll::Embed** plugin is available from the `jekyll-embed` gem.

## Usage

**Jekyll::Embed** relies on two special fields in the Jekyll page front matter to do its thing - `_links` and `_embedded`. These concepts come from the Hypermedia Application Language (HAL) media type specification.

* `_links` container of links to other resources
* `_embedded` container for other resources

For the purposes of this **Jekyll::Embed** plugin, a Jekyll page and resource can be considered the same thing.

### Steps

1. Declare which resources should embed which other resources by setting the page's default `embed` values in the `config.yml` file.

  The following tells **Jekyll::Embed** to embed `friends` resources in all pages found in `people/`.

  ```yaml
  # _config.yml
  defaults:
    - scope:
        path: "people"
        type: "pages"
      values:
        embed: [friends]
  ```

2. Define `_links` to other resources in each Jekyll page's front matter.

  ```yaml
  # people/jill.md (front matter only)
  _links:
    friends:
      - title: Bob
        url: /people/bob

      - title: Jack
        url: /people/jack

  name: Jill
  age: 6
  ```

  ```yaml
  # people/jack.md (front matter only)
  _links:
    friends:
      - title: Bob
        url: /people/bob

      - title: Jill
        url: /people/jill

  name: Jack
  age: 7
  ```

### Result

**Jekyll::Embed** embeds each resource's `friends` into `_embedded`.

```yaml
# people/jill.md (front matter only)
_links:
  friends:
    - title: Bob
      url: /people/bob

    - title: Jack
      url: /people/jack

name: Jill
age: 6

_embedded:
  friends:
    - _links:
        friends:
          - title: Jill
            url: /people/jill

          - title: Jack
            url: /people/jack

      name: Bob
      age: 5

    - _links:
        friends:
          - title: Bob
            url: /people/bob

          - title: Jill
            url: /people/jill

      name: Jack
      age: 7
```

```yaml
# people/jack.md (front matter only)
_links:
  friends:
    - title: Bob
      url: /people/bob

    - title: Jill
      url: /people/jill

name: Jack
age: 7

_embedded:
  friends:
    - _links:
        friends:
          - title: Jill
           url: /people/jill

          - title: Jack
           url: /people/jack

      name: Bob
      age: 5

    - _links:
        friends:
          - title: Bob
            url: /people/bob

          - title: Jack
            url: /people/jack

      name: Jill
      age: 6
```

## Contributing

1. Fork it (https://github.com/gregoryjscott/jekyll-embed/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request.
