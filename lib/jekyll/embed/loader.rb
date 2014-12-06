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
          embed_linked_resources(page)
        end
      end

      def embed_linked_resources(page)
        links = page.data['_links']
        return if links.nil?

        links.keys.each do |key|
          linked_resources = links[key]
          if linked_resources.kind_of?(Array)
            linked_resources.each do |linked_resource|
              resource = find_resource(linked_resource['url'])
              embed_resource_array(page, key, resource) unless resource.nil?
            end
          else
            resource = find_resource(linked_resources['url'])
            embed_resource(page, key, resource) unless resource.nil?
          end
        end
      end

      def embed_resource_array(page, key, resource)
        page.data['_embedded'] = { } if page.data['_embedded'].nil?
        page.data['_embedded'][key] = [] if page.data['_embedded'][key].nil?
        page.data['_embedded'][key] << resource['data']
      end

      def embed_resource(page, key, resource)
        page.data['_embedded'] = { } if page.data['_embedded'].nil?
        page.data['_embedded'][key] = resource['data']
      end

      def capture_resources
        @all_resources = []
        @site.pages.each do |page|
          resource = {
            'url' => page.url,
            'data' => clone(page.data)
          }
          @all_resources << resource
        end
      end

      def find_resource(url)
        @all_resources.detect { |resource| url == resource['url'] }
      end

      def clone(resource)
        json = JSON.dump(resource)
        JSON.parse(json)
      end

    end
  end
end
