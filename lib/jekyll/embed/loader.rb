module Jekyll
  module Embed
    class Loader < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { embed_resources }
      end

      def embed_resources
      end

    end
  end
end
