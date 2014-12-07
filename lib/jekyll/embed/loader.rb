module Jekyll
  module Embed
    class Loader < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { embed }
      end

      def embed
        capture_resources

        @site.pages.each do |page|
          embed_resources(page)
        end
      end

      def embed_resources(page)
        links = page.data['_links']
        return if links.nil?

        embedded = get_embedded(page)

        links.keys.each do |key|
          link_object = links[key]
          if link_object.kind_of?(Array)
            embed_many(embedded, key, link_object)
          else
            embed_single(embedded, key, link_object)
          end
        end
      end

      def embed_many(embedded, key, link_objects)
        embedded[key] = [] if embedded[key].nil?

        link_objects.each do |link_object|
          resource = find_resource(link_object['href'])
          embedded[key] << resource['data'] unless resource.nil?
        end
      end

      def embed_single(embedded, key, link_object)
        resource = find_resource(link_object['href'])
        embedded[key] = resource['data'] unless resource.nil?
      end

      def get_embedded(page)
        page.data['_embedded'] = { } if page.data['_embedded'].nil?
        page.data['_embedded']
      end

      def capture_resources
        @resources = []
        @site.pages.each do |page|
          @resources << {
            'href' => page.url,
            'data' => clone(page.data)
          }
        end
      end

      def find_resource(url)
        @resources.detect { |resource| url == resource['href'] }
      end

      def clone(resource)
        json = JSON.dump(resource)
        JSON.parse(json)
      end

    end
  end
end
