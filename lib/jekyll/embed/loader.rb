module Jekyll
  module Embed
    class Loader < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { embed_resources }
      end

      def embed_resources
        bob = @site.pages.detect { |page| page.path == 'people/bob.md'}
        jill = @site.pages.detect { |page| page.path == 'people/jill.md'}
        jack = @site.pages.detect { |page| page.path == 'people/jack.md'}

        bob_data = clone(bob.data)
        jill_data = clone(jill.data)
        jack_data = clone(jack.data)

        @site.pages.each do |page|
          page.data['_embedded'] = { }
          case page.data['title']
          when 'Bob'
            page.data['_embedded']['friends'] = [jill_data, jack_data]
          when 'Jill'
            page.data['_embedded']['friends'] = [bob_data, jack_data]
          when 'Jack'
            page.data['_embedded']['friends'] = [bob_data, jill_data]
          end
        end
      end

      def clone(resource)
        json = JSON.dump(resource)
        JSON.parse(json)
      end

    end
  end
end
