# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module Converters
    class Markdown::CMark
      def initialize(config)
        @config = config
      end

      def convert(content)
        require 'commonmarker'
        CommonMarker.render_doc(content, [:smart, :normalize]).to_html.strip
      end
    end
  end
end
